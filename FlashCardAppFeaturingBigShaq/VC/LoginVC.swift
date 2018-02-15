//
//  LoginViewController.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    let allDecksVC = AllDecksVC()
    
    var loggedIn: Bool = true //TODO: Replace with Firebase logged in function

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {
        //This should always be the bottom view in the nav stack
        self.view.addSubview(loginView)
        
        if loggedIn == true {
            navigationController?.pushViewController(allDecksVC, animated: false)
            
        }
    }
    


}
