//
//  MatchGameEndViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan on 11/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class MatchGameEndViewController: UIViewController {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling: Button (Retry Button)
        retryButton.layer.borderColor = UIColor.white.cgColor
//        retryButton.layer.borderWidth = 1
        retryButton.layer.cornerRadius = 15
        retryButton.layer.backgroundColor = UIColor.white.cgColor
        
        // Styling: Button (Home BUtton)
        homeButton.layer.borderColor = UIColor.white.cgColor
//        homeButton.layer.borderWidth = 1
        homeButton.layer.cornerRadius = 15
        homeButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    
    @IBAction func retryOnClick(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let gameStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let gameViewController = gameStoryBoard.instantiateViewController(withIdentifier: "matchGame") as! GameViewController
            gameViewController.modalTransitionStyle = .flipHorizontal
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func homeOnClick(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let homeStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = homeStoryBoard.instantiateViewController(withIdentifier: "home")
            homeViewController.modalTransitionStyle = .crossDissolve
            self.present(homeViewController, animated: true, completion: nil)
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
