//
//  CreateAccountVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/17/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountVC: UIViewController {

    let createAccountView = CreateAccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupViews()
    }
    private func setupViews() {
        self.view.addSubview(createAccountView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
