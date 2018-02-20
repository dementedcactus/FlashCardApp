//
//  AddingThingsVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/15/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddingThingsVC: UIViewController {

    private let addingThingsView = AddingThingsView()
    private let addDeckVC = AddDeckVC()
    private let addCardVC = AddCardVC()
    
    private var decksToPassOn = [Deck]()
    
    public func decksToPassIn(decksToPassIn: [Deck]) {
        self.decksToPassOn = decksToPassIn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        self.view.addSubview(addingThingsView)
        self.view.backgroundColor = .clear
        
        addingThingsView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
        addingThingsView.addDeckButton.addTarget(self, action: #selector(addDeckAction), for: .touchUpInside)
        addingThingsView.addCardButton.addTarget(self, action: #selector(addCardAction), for: .touchUpInside)
    }
    
    @objc private func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addDeckAction() {
        //This is where the add Deck Alert would go
        //This can be an alertview with a title, textfield, a ok and cancel button
        let alert = UIAlertController(title: "Create Deck", message: "Enter the name of your new deck", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "example"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField.text!)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        
        
        /*
        addDeckVC.modalTransitionStyle = .coverVertical
        addDeckVC.modalPresentationStyle = .overCurrentContext
        present(addDeckVC, animated: true, completion: nil)
         */
    }
    
    @objc private func addCardAction() {
        addCardVC.modalTransitionStyle = .coverVertical
        addCardVC.modalPresentationStyle = .overCurrentContext
        addCardVC.decksToPassIn(decksToPassIn: decksToPassOn)
        present(addCardVC, animated: true, completion: nil)
    }

    

}
