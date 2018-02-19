//
//  AddDeckVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/18/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddDeckVC: UIViewController {

    let addDeckView = AddDeckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .clear
        view.addSubview(addDeckView)
        addDeckView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
            }
}


