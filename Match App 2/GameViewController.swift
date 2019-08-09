//
//  GameViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var cardArray = [Card]()
    var model = CardModel()
    
    var firstCardFlippedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self

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
        
//        print("idx: \(indexPath)")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let selectedCard = cardArray[indexPath.row]
        
        if selectedCard.isFlipped == false {
            
            selectedCard.isFlipped = true
            selectedCell?.flip()
            
            if firstCardFlippedIndex == nil {
                // flip the first card only
                
                firstCardFlippedIndex = indexPath
                
            } else {
                // flip the second card
                // check if they are matched
                
                let previousSelectedCell = collectionView.cellForItem(at: firstCardFlippedIndex!) as? CardCollectionViewCell
                let previousSelectedCard = cardArray[firstCardFlippedIndex!.row]
                
                if previousSelectedCard.cardName == selectedCard.cardName {
                    
                    // Matched
                    previousSelectedCard.isMatched = true
                    selectedCard.isMatched = true
                    
                    // Remove both Cards
                    previousSelectedCell?.remove()
                    selectedCell?.remove()
                    
                } else {
                    
                    // Not matched
                    selectedCard.isFlipped = false
                    previousSelectedCard.isFlipped = false
                    
                    previousSelectedCell?.flipBack()
                    selectedCell?.flipBack()
                    
                }
                
                // previousSelectedCell = nil & Cell hasn't been refreshed
                if previousSelectedCell == nil {
                    collectionView.reloadItems(at: [firstCardFlippedIndex!])
                }
                
                // Reset index as all cards are being flipped back
                firstCardFlippedIndex = nil
                
            }
            
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
