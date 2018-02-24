//
//  AddCardVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/18/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AddCardVC: UIViewController {

    let addCardView = AddCardView()
    
    
    // Each Deck is a Category. The categories array should actually be populated by the names of the decks.
    
    let categories = ["Arrays", "Big O Runtimes", "Bits/Bytes/Number Systems", "Data Structures", "General", "Graphs", "Hashmaps", "Life Cycles", "LinkedLists", "Queues", "Recursion", "Sorting", "Stacks", "Trees", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addCardView.categoryTableView.dataSource = self
        addCardView.categoryTableView.delegate = self
        addCardView.categoryButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        addCardView.addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        DatabaseService.manager.showAlertDelegate = self
    }
    
    @objc private func addButtonAction() {
//        if currentReachabilityStatus == .notReachable {
//            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
//            self.present(noInternetAlert, animated: true, completion: nil)
//            return
//        }
        
        if let front = addCardView.frontTextField.text, !front.isEmpty {
            if let back = addCardView.backTextField.text, !back.isEmpty {
                
                guard let category = addCardView.categoryButton.currentTitle, category != "Category" else {
                    let alert = Alert.createErrorAlert(withMessage: "Please pick a category before posting.")
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                let card = Card(question: front, answer: back, category: category, gotRight: false, userID: (AuthUserService.manager.getCurrentUser()?.uid)!)
                DatabaseService.manager.addCard(card)
                
                //TODO: Add custom delegate for alert when card adds to the database
                
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
        print("Button tapped")
        if addCardView.categoryTableView.isHidden == true {
            addCardView.categoryTableView.isHidden = false
            animateCategoryTV()
        } else {
            addCardView.categoryTableView.isHidden = true
        }
    }
    
    private func animateCategoryTV() {
        addCardView.categoryTableView.reloadData()
        let cells = addCardView.categoryTableView.visibleCells
        let tableViewHeight = addCardView.categoryTableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .clear
        view.addSubview(addCardView)
        addCardView.dismissView.addTarget(self, action: #selector(dismissViewAction), for: .touchUpInside)
    }
    
    @objc func dismissViewAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
extension AddCardVC: UITableViewDataSource {
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
extension AddCardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let category = categories[indexPath.row]
            addCardView.categoryButton.setTitle(category, for: .normal)
            addCardView.categoryTableView.isHidden = true
    }
}
extension AddCardVC: ShowAlertDelegate {
    func showAlertDelegate(cardOrDeck: String) {
        let alert = Alert.create(withTitle: "Success", andMessage: "\(cardOrDeck) added!", withPreferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}

