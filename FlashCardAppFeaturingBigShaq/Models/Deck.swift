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

class DSA: Codable {
    static let sampleMatrix: [Deck] = [Deck(name: "Trees", numberOfCards: 5, cards: nil), Deck(name: "Wanada", numberOfCards: 15, cards: nil), Deck(name: "MergeSort", numberOfCards: 9, cards: [Card(question: "What is Two Plus Two", answer: "Four", category: "Quick Math", gotRight: true)])]
}
