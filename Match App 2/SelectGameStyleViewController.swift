//
//  SelectGameStyleViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 15/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class SelectGameStyleViewController: UIViewController {
    
    @IBOutlet weak var pokerStackView: UIStackView!
    @IBOutlet weak var cartononStackView: UIStackView!
    @IBOutlet weak var pokerView: UIView!
    @IBOutlet weak var pokerBackgroundImageView: UIImageView!
    @IBOutlet weak var cartoonView: UIView!
    @IBOutlet weak var cartoonBackgroundImageView: UIImageView!
    
    static var gameStyle = "poker"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokerBackgroundImageView.layer.cornerRadius = 10
        pokerBackgroundImageView.clipsToBounds = true
        cartoonBackgroundImageView.layer.cornerRadius = 10
        cartoonBackgroundImageView.clipsToBounds = true
        
        if SelectGameStyleViewController.gameStyle == "poker" {
            pokerView.layer.borderWidth = 8
            pokerView.layer.borderColor = UIColor.white.cgColor
            pokerView.layer.cornerRadius = 10
        } else {
            cartoonView.layer.borderWidth = 8
            cartoonView.layer.borderColor = UIColor.white.cgColor
            cartoonView.layer.cornerRadius = 10
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
