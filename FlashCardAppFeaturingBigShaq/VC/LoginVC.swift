//
//  LoginViewController.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    let allDecksVC = AllDecksVC()
    let createAccountVC = CreateAccountVC()
    
    var loggedIn: Bool = false //TODO: Replace with Firebase logged in function

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        loginView.signInButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        loginView.facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        loginView.twitterSignInButton.addTarget(self, action: #selector(twitterButtonPressed), for: .touchUpInside)
//        loginView.signInButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        setupViews()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //        //if the user has already logged in before
        if let user = AuthUserService.manager.getCurrentUser() {
            // currently: if there is a user already logged in, autofill email but need to enter password
            self.loginView.emailTextField.text = user.email
            print("User identified. Display Name: \(String(describing: user.displayName)), Email: \(String(describing: user.email))")
            self.navigationController?.pushViewController(allDecksVC, animated: false)
        } else {
            print("there is no user")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if the user has already logged in before
//        if let user = AuthUserService.manager.getCurrentUser() {
//            // currently: if there is a user already logged in, autofill email but need to enter password
//            self.loginView.emailTextField.text = user.email
//            print("User identified. Display Name: \(String(describing: user.displayName)), Email: \(String(describing: user.email))")
//            self.navigationController?.pushViewController(allDecksVC, animated: true)
//        } else {
//            print("there is no user")
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {
        self.view.addSubview(loginView)
//        if loggedIn == true {
//            navigationController?.pushViewController(allDecksVC, animated: false)
//        }
    }
    
    @objc func loginButtonPressed() {
        print("Log In button pressed")
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
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
        
        //SVProgressHUD.isVisible()
        //SVProgressHUD.show()
        
        AuthUserService.manager.delegate = self
        AuthUserService.manager.login(withEmail: email!, andPassword: password!)
        
        //navigationController?.pushViewController(allDecksVC, animated: true)
    }
    
    @objc func twitterButtonPressed() {
    }
    
    @objc func facebookButtonPressed() {
    }
    
    @objc func createAccountButtonPressed() {
        navigationController?.pushViewController(createAccountVC, animated: false)
    }
    
    @objc func resetPassword() {
        print("Reset button pressed")
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Password Reset", message: "Enter your email to reset your password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "example@email.com"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField.text!)")
            if let emailText = textField.text, !emailText.isEmpty {
                AuthUserService.manager.delegate = self
                AuthUserService.manager.forgotPassword(withEmail: emailText)
                self.dismiss(animated: true, completion: nil)
            } else {
                let errorAlert = Alert.createErrorAlert(withMessage: "Nothing was entered in the textfield.")
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Text Field Delegates
extension LoginVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // for email textfield
        if textField == loginView.emailTextField {
            // check if field is not empty
            guard let userEmail = textField.text, userEmail != "" else { return }
        }
        // for password textfield
        if textField == loginView.passwordTextField {
            // check if field is not empty
            guard let userPass = textField.text, userPass != "" else { return }
            // makes the entered text into secret password form
            textField.isSecureTextEntry = true
        }
/*
        // for reset password textfield
        if textField == forgotPassView.resetEmailTextField {
            // check if field is not empty
            guard let enteredEmail = textField.text, enteredEmail != "" else { return }
        }
 */
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
extension LoginVC: AuthUserServiceDelegate {
    func didFailLogin(_ authUserService: AuthUserService, error: String) {
        showAlert(title: "Incorrect Email/Password", message: "Please try again.")
        print("Login failed")
    }
    
    func didLogin(_ authUserService: AuthUserService, userProfile: UserProfile) {
        print("Log in successful for \(userProfile.displayName), \(userProfile.email)")
        //SVProgressHUD.dismiss()
        navigationController?.pushViewController(allDecksVC, animated: true)
    }
    
//    func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String) {
//        print("didFailEmailVerification")
//        showAlert(title: "Error", message: "\(error)")
//    }
//    
//    func didSendEmailVerification(_ authUserService: AuthUserService, user: User, message: String) {
//        print("didSendEmailVerification")
//        showAlert(title: "Error", message: "Verification email sent")
//    }
    func didFailForgotPassword(_ authUserService: AuthUserService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didSendForgotPassword(_ authUserService: AuthUserService) {
        let alert = Alert.create(withTitle: "An email has been sent to reset your password.", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: alert)
        self.present(alert, animated: true, completion: nil)
    }
}
