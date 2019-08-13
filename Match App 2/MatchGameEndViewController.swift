//
//  MatchGameEndViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan on 11/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class MatchGameEndViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.clearColor()
//        view.opaque = false
        
        // Styling: Button (Retry Button)
        let retryButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        retryButton.setTitle("Retry", for: .normal)
        retryButton.backgroundColor = .white
        retryButton.layer.cornerRadius = 15
        retryButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(retryButton)
        
        // Styling: Button (Home BUtton)
//        homeButton.setTitle("Home", for: .normal)
//        homeButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
//        homeButton.layer.cornerRadius = 15
    }
    
    @objc func buttonAction() {
        print("retry...")
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
