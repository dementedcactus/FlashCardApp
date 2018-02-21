//
//  Deck.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Deck: Codable {
    static let sampleMatrix = [Deck(name: "Trees", numberOfCards: 0, cards: nil),
                               Deck(name: "Wakanda", numberOfCards: 0, cards: nil),
                               Deck(name: "QuickMath", numberOfCards: Card.sampleQuickMath.count, cards: Card.sampleQuickMath)]
    
    var name: String
    var numberOfCards: Int?
    var cards: [Card]?
    
    init(name: String, numberOfCards: Int, cards: [Card]? ) {
        self.name = name
        self.numberOfCards = numberOfCards
        self.cards = cards
    }
}

