//
//  SelectGameStyleViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 15/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class SelectGameStyleViewController: UIViewController {
    
    @IBOutlet weak var pokerView: UIView!
    @IBOutlet weak var pokerBackgroundImageView: UIImageView!
    @IBOutlet weak var cartoonView: UIView!
    @IBOutlet weak var cartoonBackgroundImageView: UIImageView!
    
    static var gameStyle = "poker"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling - Background Image
        pokerBackgroundImageView.layer.cornerRadius = 10
        pokerBackgroundImageView.clipsToBounds = true
        cartoonBackgroundImageView.layer.cornerRadius = 10
        cartoonBackgroundImageView.clipsToBounds = true
        
        // Tap Gesture - Setup for both View
        let pokerTapGesture = UITapGestureRecognizer(target: self, action: #selector(styleOnClick(from:)))
        let cartoonTapGesture = UITapGestureRecognizer(target: self, action: #selector(styleOnClick(from:)))
        pokerView.addGestureRecognizer(pokerTapGesture)
        pokerView.isUserInteractionEnabled = true
        cartoonView.addGestureRecognizer(cartoonTapGesture)
        cartoonView.isUserInteractionEnabled = true
    }
    
    // MARK: - Game style onClick Function
    @objc func styleOnClick(from: UIGestureRecognizer) {
        
        if from.view == pokerView {
            SelectGameStyleViewController.gameStyle = "poker"
        } else if from.view == cartoonView {
            SelectGameStyleViewController.gameStyle = "cartoon"
        }
        
        let gameStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let matchGameViewController = gameStoryBoard.instantiateViewController(withIdentifier: "matchGame") as! GameViewController
        self.present(matchGameViewController, animated: true, completion: nil)
        
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
