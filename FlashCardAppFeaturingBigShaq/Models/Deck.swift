//
//  Deck.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Deck: Codable {
    
    var userID: String
    var name: String
    var numberOfCards: Int?
    
    init(userID: String, name: String, numberOfCards: Int) {
        self.userID = userID
        self.name = name
        self.numberOfCards = numberOfCards
        
    }
}

