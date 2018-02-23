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
    var deck = [Card]()
    var currentCard = 0 //The index you're currently at in the deck
    var widthValue: CGFloat = 0
    var heightValue: CGFloat  = 0
    var xOffSet: CGFloat = 0
    var yOffSet: CGFloat = 0
    
    var startingPosition: CGRect = .zero {
        didSet {
            self.widthValue = startingPosition.width
            self.xOffSet = startingPosition.minX
            self.yOffSet = startingPosition.minY
            self.heightValue = startingPosition.height
        }
    }
    
    public func injectADeck(deck: [Card]) {
        self.deck = deck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startingPosition = deckView.questionTextView.frame
    }
    
    private func setupView() {
        self.view.addSubview(deckView)
        deckView.showAnswerButton.addTarget(self, action: #selector(showAnswerClicked), for: .touchUpInside)
        deckView.repeatButton.addTarget(self, action: #selector(repeatClicked), for: .touchUpInside)
        deckView.nextQuestionButton.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
        deckView.previousButton.addTarget(self, action: #selector(previousClicked), for: .touchUpInside)
        if deck.isEmpty {
            deckView.questionTextView.text = "No data in this deck"
        } else {
            loadCard()
        }
    }
    
    private func loadCard() {
        deckView.questionTextView.text = deck[currentCard].question
        deckView.answerTextView.text = deck[currentCard].answer
        navigationItem.title = deck[currentCard].category
    }
    
    @objc private func showAnswerClicked() {
        UIView.animate(withDuration: 1.0) {
            self.deckView.questionTextView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(CGFloat.pi)) / 180.0)
            self.deckView.questionTextView.alpha = 0.0
        }
    }
    @objc private func repeatClicked() {
        deckView.questionTextView.alpha = 1
        deckView.questionTextView.frame = startingPosition
        deckView.questionTextView.transform = CGAffineTransform(rotationAngle: (0))
    }
    @objc private func nextClicked() {
        
        currentCard += 1
        if currentCard > deck.count - 1 {
            let alert = Alert.create(withTitle: "End", andMessage: "End of Deck Reached", withPreferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            loadCard()
            repeatClicked()
        }
    }
    
    @objc private func previousClicked() {
        
        currentCard -= 1
        if currentCard < 0 {
            let alert = Alert.create(withTitle: "Beginning", andMessage: "Beginning of Deck Reached", withPreferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            loadCard()
            repeatClicked()
        }
    }
    
    
    
}
