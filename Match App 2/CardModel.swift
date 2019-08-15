//
//  CardModel.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedArray = [Card]()
        var randomNumberArray = [Int]()
        
        while randomNumberArray.count < 12 {
            
            let randomNumber = Int.random(in: 2...14)
            
            if randomNumberArray.contains(randomNumber) == false {
                
                let cardA = Card()
                let cardB = Card()
                
                if SelectGameStyleViewController.gameStyle == "poker" {
                    cardA.cardName = "card\(randomNumber)"
                    cardB.cardName = "card\(randomNumber)"
                } else {
                    cardA.cardName = "card_special\(randomNumber)"
                    cardB.cardName = "card_special\(randomNumber)"
                }
                
                generatedArray.append(cardA)
                generatedArray.append(cardB)
                
                randomNumberArray.append(randomNumber)
                
            }
            
        }
        
        generatedArray.shuffle()
        
        return generatedArray
        
    }
    
}
