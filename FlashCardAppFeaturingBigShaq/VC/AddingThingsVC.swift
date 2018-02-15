//
//  AddingThingsVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/15/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddingThingsVC: UIViewController {

    let addingThingsView = AddingThingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        self.view.addSubview(addingThingsView)
        self.view.backgroundColor = .clear
        
        addingThingsView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
