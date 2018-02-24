//
//  DatabaseService+Edit.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DatabaseService {
    public func editPost(_ card: Card){
        
            //1. find ref
            let ref = cardsRef.child(card.cardUID)
            
            //2. call set value with completion handler
            ref.updateChildValues(["question": card.question,
                          "answer": card.answer,
                          "category": card.category,
                          "gotRight": card.gotRight ?? false,
                          "userID": card.userID,
                          "cardUID": card.cardUID]) { (error, nil) in
                            if let error = error {
                                print(error)
                            } else {
                                print("Card Added")
                            }
            }
            self.refreshDelegate?.refreshTableView()
            self.showAlertDelegate?.showAlertDelegate(cardOrDeck: "Card Edits")
        
 
    }
}
