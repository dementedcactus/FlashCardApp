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
    let menuVC = MenuVC()
    let addingThingsVC = AddingThingsVC()
    
    let sampleMatrix: [Deck] = [Deck(name: "Trees", numberOfCards: 5, cards: nil), Deck(name: "Wanada", numberOfCards: 15, cards: nil), Deck(name: "MergeSort", numberOfCards: 9, cards: nil)]
        
    
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
    }
    
    @objc func rightBarButtonClicked() {
        
        menuVC.modalTransitionStyle = .coverVertical
        menuVC.modalPresentationStyle = .overCurrentContext
        present(menuVC, animated: true, completion: nil)
    }
    
    @objc func leftBarButtonClicked() {
        
        addingThingsVC.modalTransitionStyle = .crossDissolve
        addingThingsVC.modalPresentationStyle = .overCurrentContext
        present(addingThingsVC, animated: true, completion: nil)
    }
    
    // Make the Status Bar Light/Dark Content for this VC
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent //UIStatusBarStyle.default // Make dark again
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTable()
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
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
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

}
extension AllDecksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
        //Add segue to DeckVC
        //Dependency Inject the Deck into DeckVC
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











