//
//  EditCardVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EditCardVC: UIViewController {

    let editCardView = EditCardView()
    var cardToEdit: Card!
    
    public func getCardToEdit(card: Card){
        self.cardToEdit = card
    }
    
    // Each Deck is a Category. The categories array should actually be populated by the names of the decks.
    
    let categories = ["Arrays", "Big O Runtimes", "Bits/Bytes/Number Systems", "Data Structures", "General", "Graphs", "Hashmaps", "Life Cycles", "LinkedLists", "Queues", "Recursion", "Sorting", "Stacks", "Trees", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        DatabaseService.manager.showAlertDelegate = self
    }
    
    private func setupView() {
        self.view.backgroundColor = .clear
        view.addSubview(editCardView)
        editCardView.categoryTableView.dataSource = self
        editCardView.categoryTableView.delegate = self
        editCardView.frontTextField.delegate = self
        //editCardView.backTextField.delegate = self
        editCardView.categoryButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        editCardView.editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        editCardView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
        
        // Set up fields based on the old card
        editCardView.categoryButton.setTitle(cardToEdit.category, for: .normal)
        editCardView.frontTextField.text = cardToEdit.question
        editCardView.backTextField.text = cardToEdit.answer
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func editButtonAction() {
        //        if currentReachabilityStatus == .notReachable {
        //            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
        //            self.present(noInternetAlert, animated: true, completion: nil)
        //            return
        //        }
        
        if let front = editCardView.frontTextField.text, !front.isEmpty {
            if let back = editCardView.backTextField.text, !back.isEmpty {
                
                guard let category = editCardView.categoryButton.currentTitle, category != "Category" else {
                    let alert = Alert.createErrorAlert(withMessage: "Please pick a category before editing.")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let card = Card(question: front, answer: back, category: category, gotRight: false, userID: cardToEdit.userID, cardUID: cardToEdit.cardUID)
                DatabaseService.manager.editPost(card)
                
            } else {
                //This triggers if user didn't put text in the backTextView
                let alert = Alert.createErrorAlert(withMessage: "Please have something for the back of the card before you add.")
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // This triggers if the user didn't put text in the frontTextView
            let alert = Alert.createErrorAlert(withMessage: "Please enter a front item for your card.")
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        if editCardView.categoryTableView.isHidden == true {
            editCardView.categoryTableView.isHidden = false
            animateCategoryTV()
        } else {
            editCardView.categoryTableView.isHidden = true
        }
    }
    
    private func animateCategoryTV() {
        editCardView.categoryTableView.reloadData()
        let cells = editCardView.categoryTableView.visibleCells
        let tableViewHeight = editCardView.categoryTableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
        }
        var delayCounter: Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
        }
    }
    
}
extension EditCardVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var displaycell = UITableViewCell()
        
        var cell:CategoryTableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell
        
        let category = categories[indexPath.row]
        cell!.categoryLabel.text = "\(category)"
        displaycell = cell!
        
        return displaycell
    }
    
}
extension EditCardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        editCardView.categoryButton.setTitle(category, for: .normal)
        editCardView.categoryTableView.isHidden = true
    }
}
extension EditCardVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
extension EditCardVC: ShowAlertDelegate {
    func showAlertDelegate(cardOrDeck: String) {
        let alert = Alert.create(withTitle: "Success", andMessage: "\(cardOrDeck) added!", withPreferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


