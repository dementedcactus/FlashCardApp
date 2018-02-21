//
//  LoginViewController.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    let allDecksVC = AllDecksVC()
    let createAccountVC = CreateAccountVC()
    
    var loggedIn: Bool = false //TODO: Replace with Firebase logged in function

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
        
        loginView.signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        loginView.createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        loginView.facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        loginView.twitterSignInButton.addTarget(self, action: #selector(twitterButtonPressed), for: .touchUpInside)
        loginView.signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    @objc func signInButtonPressed() {
        
        /*
        guard loginView.emailTextField.text != "" else {
            let alert = Alert.createErrorAlert(withMessage: "Please Enter an Email")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard loginView.passwordTextField.text != "" else {
            let alert = Alert.createErrorAlert(withMessage: "Please Enter a Password")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let email = loginView.emailTextField.text
        let password = loginView.passwordTextField.text
        //TODO Firebase func for logging in
        */
        
        navigationController?.pushViewController(allDecksVC, animated: true)
    }
    
    @objc func twitterButtonPressed() {
        
    }
    
    @objc func facebookButtonPressed() {
        
    }
    
    @objc func createAccountButtonPressed() {
        navigationController?.pushViewController(createAccountVC, animated: false)
    }
    
    @objc func forgotPasswordButtonPressed() {
        let alert = UIAlertController(title: "Password Reset", message: "Enter your email to reset your password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "example@email.com"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField.text!)")
        }))
        self.present(alert, animated: true, completion: nil)
        return
    }


}

