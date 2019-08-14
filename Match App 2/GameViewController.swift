//
//  GameViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var timerTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardArray = [Card]()
    var model = CardModel()
    
    var firstCardFlippedIndex: IndexPath?
    
    var timer: Timer?
    var milliseconds: Float = 12 * 1000
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling - Timer
        timerTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.timerTextField.frame.height))
        timerTextField.leftViewMode = .always
        
        // Initiate Timer
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(timeElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        playSound("shuffle")
        cardArray = model.getCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        // Set front Image View for each card
        cell.setCards(card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if milliseconds == 0 { return }
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let selectedCard = cardArray[indexPath.row]
        
        if selectedCard.isFlipped == false {
            
            selectedCard.isFlipped = true
            selectedCell?.flip()
            playSound("cardflip")
            
            if firstCardFlippedIndex == nil {
                
                // flipped the first card only
                firstCardFlippedIndex = indexPath
                
            } else {
                
                checkIfMatch(collectionView, indexPath)
                
            } // End of if first card is being flipped over
            
        } // End of if selected card has not been flipped yet
        
    } // End of collectionView didSelect
    
    // MARK: - Check Match Function
    func checkIfMatch(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        
        let previousSelectedCell = collectionView.cellForItem(at: firstCardFlippedIndex!) as? CardCollectionViewCell
        let previousSelectedCard = cardArray[firstCardFlippedIndex!.row]
        
        let nowSelectedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let nowSelectedCard = cardArray[indexPath.row]
        
        if previousSelectedCard.cardName == nowSelectedCard.cardName {
            
            // Matched
            previousSelectedCard.isMatched = true
            nowSelectedCard.isMatched = true
            
            // Remove both Cards
            previousSelectedCell?.remove()
            nowSelectedCell?.remove()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.55) {
                self.playSound("dingcorrect")
            }
            
            checkGameEnd()
            
        } else {
            
            // Not matched
            nowSelectedCard.isFlipped = false
            previousSelectedCard.isFlipped = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.55) {
                self.playSound("dingwrong")
            }
            
            previousSelectedCell?.flipBack()
            nowSelectedCell?.flipBack()
            
        }
        
        // previousSelectedCell = nil & Cell hasn't been refreshed
        if previousSelectedCell == nil {
            collectionView.reloadItems(at: [firstCardFlippedIndex!])
        }
        
        // Reset index as all cards are being flipped back
        firstCardFlippedIndex = nil
        
    }
    
    // MARK: - Check Game End Function
    func checkGameEnd() {
        
        // check if it ends
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
            }
        }
        
        if isWon == true {
            timer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
                self.afterGameModal()
            }
        }
    }
    
    //MARK: - Add modalViewController on top of current view (when game is end)
    func afterGameModal(win: Bool = true) {
        
        // Blur current screen
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurredBackgroundView)
        
        let endStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let matchGameEndViewController = endStoryBoard.instantiateViewController(withIdentifier: "matchGameEnd") as! MatchGameEndViewController
        matchGameEndViewController.modalTransitionStyle = .coverVertical
        // Change textLabel
        if win == true {
            MatchGameEndViewController.win = true
        } else {
            MatchGameEndViewController.win = false
        }
        self.present(matchGameEndViewController, animated: true, completion: nil)
        
    }
    
    // MARK: - Timer function
    @objc func timeElapsed() {
        
        milliseconds -= 4
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        if milliseconds == 0 {
            
            checkGameEnd()
            timer?.invalidate()
            timerTextField.text = "Time Remaining: 0"
            timerTextField.textColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
                self.afterGameModal(win: false)
            }
            
        } else if milliseconds > 0 {
            
            timerTextField.text = "Time Remaining: \(seconds)"
            
        }
        
    }
    
    // MARK: - Sound function
    func playSound(_ type: String = "cardflip") {
        
        guard let url = Bundle.main.url(forResource: "\(type)", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
