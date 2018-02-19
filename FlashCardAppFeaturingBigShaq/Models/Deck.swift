//
//  Deck.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Deck: Codable {
    var name: String
    var numberOfCards: Int?
    var cards: [Card]?
    
    init(name: String, numberOfCards: Int, cards: [Card]? ) {
        self.name = name
        self.numberOfCards = numberOfCards
        self.cards = cards
    }
}
