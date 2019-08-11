//
//  GameViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var timerTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardArray = [Card]()
    var model = CardModel()
    
    var firstCardFlippedIndex: IndexPath?
    
    var timer: Timer?
    var milliseconds: Float = 60 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling - Timer
        timerTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: self.timerTextField.frame.height))
        timerTextField.leftViewMode = .always
        
        // Initiate Timer
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(timeElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        collectionView.dataSource = self
        collectionView.delegate = self

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
            
            if firstCardFlippedIndex == nil {
                // flip the first card only
                
                firstCardFlippedIndex = indexPath
                
            } else {
                
                checkIfMatch(collectionView, indexPath)
                
            } // End of if first card is being flipped over
            
        } // End of if selected card has not been flipped yet
        
    } // End of collectionView didSelect
    
    // MARK: - Check if Cards are Matched
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
            
        } else {
            
            // Not matched
            nowSelectedCard.isFlipped = false
            previousSelectedCard.isFlipped = false
            
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
    
    // MARK: - Timer function
    @objc func timeElapsed() {
        
        milliseconds -= 4
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        if milliseconds == 0 {
            
            timer?.invalidate()
            timerTextField.text = "Time Remaining: 0"
            timerTextField.textColor = UIColor.red
            return
            
        } else if milliseconds > 0 {
            
            timerTextField.text = "Time Remaining: \(seconds)"
            
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
