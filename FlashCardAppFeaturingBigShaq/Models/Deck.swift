//
//  Deck.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Deck: Codable {
    static let sampleMatrix = [Deck(userID: "Melissa", name: "Trees", numberOfCards: 0, cards: nil),
                               Deck(userID: "Melissa", name: "Hashmaps", numberOfCards: 0, cards: nil),
                               Deck(userID: "Richard", name: "Math", numberOfCards: Card.sampleQuickMath.count, cards: Card.sampleQuickMath)]
    
    var userID: String
    var name: String
    var numberOfCards: Int?
    var cards: [Card]?
    
    init(userID: String, name: String, numberOfCards: Int, cards: [Card]? ) {
        self.userID = userID
        self.name = name
        self.numberOfCards = numberOfCards
        self.cards = cards
    }
}

