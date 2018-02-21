//
//  Card.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/18/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Card: Codable {
    static var sampleQuickMath = [Card(question: "What is Two Plus Two",
                                       answer: "Four",
                                       category: "Quick Math",
                                       gotRight: false),
                                  Card(question: "Da Ting Go",
                                       answer: "SKRRRRRRAT!!!",
                                       category: "Quick Math",
                                       gotRight: false)]
    var question: String
    var answer: String
    var category: String
    var gotRight: Bool?
    
    init(question: String, answer: String, category: String, gotRight: Bool) {
        self.question = question
        self.answer = answer
        self.category = category
        self.gotRight = gotRight
    }
}

