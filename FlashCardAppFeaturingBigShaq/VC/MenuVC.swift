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
        menuView.decksButton.addTarget(self, action: #selector(deckButtonAction), for: .touchUpInside)
        menuView.cardBrowserButton.addTarget(self, action: #selector(cardBrowserAction), for: .touchUpInside)
        menuView.nightModeButton.addTarget(self, action: #selector(nightModeButtonAction), for: .touchUpInside)
        menuView.settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        menuView.logoutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deckButtonAction() {
        // TODO
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cardBrowserAction() {
        // TODO
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nightModeButtonAction() {
        // TODO
        dismiss(animated: true, completion: nil)
    }
    
    @objc func settingsButtonAction() {
        // TODO
        dismiss(animated: true, completion: nil)
    }
    
    @objc func logOutButtonAction() {
        // TODO
        dismiss(animated: true, completion: nil)
    }

}
