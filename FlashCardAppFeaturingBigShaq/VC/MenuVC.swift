//
//  MenuVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    let menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    private func setupView() {
        self.view.addSubview(menuView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
