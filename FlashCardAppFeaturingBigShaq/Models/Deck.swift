//
//  Deck.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Deck {
    var name: String
    var numberOfCards: Int
    
    init(name: String, numberOfCards: Int ) {
        self.name = name
        self.numberOfCards = numberOfCards
    }
}
