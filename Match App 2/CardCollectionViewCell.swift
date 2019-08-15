//
//  CardCollectionViewCell.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    func setCards(_ card: Card) {
        
        // Deal with reusable elements' issue
        if card.isMatched == true {

            frontImageView.alpha = 0
            backImageView.alpha = 0
            return

        } else {

            frontImageView.alpha = 1
            backImageView.alpha = 1
            
        }
        
        frontImageView.image = UIImage(named: card.cardName)
        
        if SelectGameStyleViewController.gameStyle == "poker" {
            backImageView.image = UIImage(named: "back")
        } else {
            backImageView.image = UIImage(named: "back_special")
        }
        
        
        // Deal with reusable elements' issue
        if card.isFlipped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews], completion: nil)
        }
        
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.55) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove() {
        
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.25, delay: 0.55, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
    
}
