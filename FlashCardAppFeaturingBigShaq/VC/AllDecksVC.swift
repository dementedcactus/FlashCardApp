//
//  AllDeckVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AllDecksVC: UIViewController {

    let allDecksView = AllDecksView()
    let menuView = MenuView()
    let addingThingsVC = AddingThingsVC()
    let allCardsVC = AllCardsVC()
    
    let sampleMatrix: [Deck] = Deck.sampleMatrix
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //TBV Delegates
        allDecksView.tableView.delegate = self
        allDecksView.tableView.dataSource = self
        allDecksView.tableView.estimatedRowHeight = 80
        allDecksView.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func setupView() {
        self.view.addSubview(allDecksView)
        allDecksView.menuButton.addTarget(self, action: #selector(rightBarButtonClicked), for: .touchUpInside)
        allDecksView.plusButton.addTarget(self, action: #selector(leftBarButtonClicked), for: .touchUpInside)
        menuView.dismissView.addTarget(self, action: #selector(dismissViewAction(sender:)), for: .touchUpInside)
        menuView.decksButton.addTarget(self, action: #selector(deckButtonAction), for: .touchUpInside)
        menuView.cardBrowserButton.addTarget(self, action: #selector(cardBrowserAction), for: .touchUpInside)
        menuView.nightModeButton.addTarget(self, action: #selector(nightModeButtonAction), for: .touchUpInside)
        menuView.settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        menuView.logoutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
    }
    
    @objc private func rightBarButtonClicked() {
        self.view.addSubview(menuView)
    }
    
    @objc private func leftBarButtonClicked() {
        addingThingsVC.modalTransitionStyle = .crossDissolve
        addingThingsVC.modalPresentationStyle = .overCurrentContext
        addingThingsVC.decksToPassIn(decksToPassIn: sampleMatrix)
        present(addingThingsVC, animated: true, completion: nil)
    }
    
    @objc func dismissViewAction(sender: UIView) {
        self.menuView.removeFromSuperview()
    }
    
    @objc func deckButtonAction() {
        self.menuView.removeFromSuperview()
    }
    
    @objc func cardBrowserAction() {
        navigationController?.pushViewController(allCardsVC, animated: true)
    }
    
    @objc func nightModeButtonAction() {
        self.menuView.removeFromSuperview()
    }
    
    @objc func settingsButtonAction() {
        self.menuView.removeFromSuperview()
    }
    
    @objc func logOutButtonAction() {
        // TODO
        AuthUserService.manager.signOut()
        self.navigationController?.popToRootViewController(animated: true)
        self.menuView.removeFromSuperview()
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Make the Status Bar Light/Dark Content for this VC
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent //UIStatusBarStyle.default // Make dark again
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func animateTable() {
        allDecksView.tableView.reloadData()
        let cells = allDecksView.tableView.visibleCells
        let tableViewHeight = allDecksView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.00, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }

}
extension AllDecksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCards = sampleMatrix[indexPath.row].cards else {
            let alert = Alert.createErrorAlert(withMessage: "This deck is empty")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //Add segue to DeckVC
        let deckVC = DeckVC()
        //Dependency Inject the Deck into DeckVC
        deckVC.injectADeck(deck: selectedCards)
        navigationController?.pushViewController(deckVC, animated: true)
    }
}
extension AllDecksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMatrix.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell", for: indexPath) as! CustomTableViewCell
        
        let aDeck = sampleMatrix[indexPath.row]
        cell.deckLabel.text = " \(aDeck.name)"
        cell.numberOfCardsInDeckLabel.text = "\(aDeck.numberOfCards ?? 0)"
        return cell
    }
    
    
}











