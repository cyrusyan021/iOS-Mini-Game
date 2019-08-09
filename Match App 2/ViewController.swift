//
//  ViewController.swift
//  Match App 2
//
//  Created by Cyrus Yan (NMG) on 9/8/2019.
//  Copyright © 2019 Cyrus Yan (NMG). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling: Button (Start Button)
        startButton.setTitle("Get Started", for: .normal)
        startButton.contentEdgeInsets = UIEdgeInsets(top: 15,left: 20,bottom: 15,right: 20)
        startButton.layer.cornerRadius = 15
    }


}

