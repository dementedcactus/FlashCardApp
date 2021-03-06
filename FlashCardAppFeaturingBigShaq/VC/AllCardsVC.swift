//
//  AllCardsVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/22/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class AllCardsVC: UIViewController {
    
    let allCardsView = AllCardsView()
    let cellSpacing: CGFloat = 5 // cell spacing
    var allCardsArray = [Card]() {
        didSet {
            allCardsView.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DatabaseService.manager.getAllFlashcards(forUserID: (AuthUserService.manager.getCurrentUser()?.uid)!) { (Cards) in
            if let cards = Cards {
                self.allCardsArray = cards
                
            } else {
                print("Couldn't get cards or there are no cards")
                //TODO: Maybe show an image of no data as a background
            }
        }
    }
    
    func setupView() {
        view.addSubview(allCardsView)
        navigationItem.title = "All Cards"
        allCardsView.collectionView.dataSource = self
        allCardsView.collectionView.delegate = self
        DatabaseService.manager.refreshDelegate = self
    }
}
extension AllCardsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let aCard = allCardsArray[indexPath.row]
        
        // Pass Card into EditCardVC
        let editCardVC = EditCardVC()
        
        editCardVC.getCardToEdit(card: aCard)
        
        // TODO: Add segue to EditCardVC
        editCardVC.modalTransitionStyle = .crossDissolve
        editCardVC.modalPresentationStyle = .overCurrentContext
        present(editCardVC, animated: true, completion: nil)
    }
    
}
extension AllCardsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allCardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCVCell", for: indexPath) as! CustomCVCell
        
        let aFlashCard = allCardsArray[indexPath.row]
        
        cell.questionTextView.text = aFlashCard.question
        cell.answerTextView.text = aFlashCard.answer
        cell.categoryLabel.text = aFlashCard.category
        
        return cell
    }
}
extension AllCardsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
extension AllCardsVC: RefreshDelegate {
    func refreshTableView() {
        DatabaseService.manager.getAllFlashcards(forUserID: (AuthUserService.manager.getCurrentUser()?.uid)!) { (Cards) in
            if let cards = Cards {
                self.allCardsArray = cards
                
            } else {
                print("Couldn't get cards or there are no cards")
                //TODO: Maybe show an image of no data as a background
            }
        }
    }
}



