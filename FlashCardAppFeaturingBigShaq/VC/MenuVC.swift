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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        self.view.addSubview(menuView)
        self.view.backgroundColor = .clear
        
        menuView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }

}
