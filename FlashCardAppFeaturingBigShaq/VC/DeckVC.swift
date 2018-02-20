//
//  DeckVC.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/13/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class DeckVC: UIViewController {

    let deckView = DeckView()
    let menuVC = MenuVC()
    var deck = [Card]()
    
    public func injectADeck(deck: [Card]) {
        self.deck = deck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(deckView)
        deckView.showAnswerButton.addTarget(self, action: #selector(showAnswerClicked), for: .touchUpInside)
        deckView.repeatButton.addTarget(self, action: #selector(repeatClicked), for: .touchUpInside)
        deckView.nextQuestionButton.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
    }
    
    @objc private func showAnswerClicked() {
        deckView.questionTextView.isHidden = true
    }
    @objc private func repeatClicked() {
        deckView.questionTextView.isHidden = false
    }
    @objc private func nextClicked() {
        //TODO
    }
    
    

}
