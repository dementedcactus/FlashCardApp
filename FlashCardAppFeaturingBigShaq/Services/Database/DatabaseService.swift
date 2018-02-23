//
//  DatabaseService.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/21/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
import FirebaseDatabase

/** This API client is responsible for fetching/pushing data from/to the Firebase database.
 */
class DatabaseService: NSObject {
    private override init() {
        self.rootRef = Database.database().reference()
        self.usersRef = self.rootRef.child("users")
        self.categoriesRef = self.rootRef.child("categories")
        self.cardsRef = self.rootRef.child("cards")
        self.decksRef = self.rootRef.child("decks")
        super.init()
    }
    
    /// The singleton object for the DatabaseService API client.
    static let manager = DatabaseService()
    
    public weak var delegate: DatabaseServiceDelegate?
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var categoriesRef: DatabaseReference!
    var cardsRef: DatabaseReference!
    var decksRef: DatabaseReference!
    
    /**
     Removes all observers from all references.
     */
    public func stopObserving() {
        rootRef.removeAllObservers()
        usersRef.removeAllObservers()
        categoriesRef.removeAllObservers()
        cardsRef.removeAllObservers()
        decksRef.removeAllObservers()
        
    }
    
    /** This method checks if the given displayName is already in use by another user.
     
     - Parameters:
     - newName: The new name to change to.
     - currentUserID: The ID of the current, authorized user.
     - completion: A closure that passes back a Bool (whether the name is in use or not), the oldName, and the newName.
     - isTaken: If the name is taken or not.
     - oldName: The previous displayName of the current user.
     - newName: The new displayName of the current user.
     */
    public func checkIfDisplayNameIsTaken(_ newName: String, currentUserID: String?, completion: @escaping (_ isTaken: Bool, _ oldName: String, _ newName: String) -> Void) {
        usersRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            var oldName: String!
            
            for childSnapShot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                
                guard let userDict = childSnapShot.value as? [String : Any] else {
                    return
                }
                guard
                    let displayName = userDict["displayName"] as? String,
                    let userID = userDict["userID"] as? String
                    else {
                        return
                }
                if let currentUserID = currentUserID {
                    if userID == currentUserID {
                        oldName = displayName
                    }
                    if newName == displayName && currentUserID != userID {
                        completion(true, oldName, newName)
                        return
                    }
                } else {
                    if newName == displayName {
                        completion(true, oldName, newName)
                        return
                    }
                }
            }
            if let oldName = oldName {
                completion(false, oldName, newName)
                
                if let currentUserID = currentUserID {
                    self.usersRef.child(currentUserID).child("displayName").setValue(newName, withCompletionBlock: { (error, _) in
                        if let error = error {
                            self.delegate?.didFailChangingDisplayName?(self, error: error.localizedDescription)
                        } else {
                            self.delegate?.didChangeDisplayName?(self, oldName: oldName, newName: newName)
                        }
                    })
                }
                
                return
            } else {
                completion(false, newName, newName)
                return
            }
        }
    }
}
/*
import Foundation
import FirebaseDatabase

@objc protocol DatabaseServiceDelegate: class {
    @objc optional func didAddFlashcard(_ databaseService: DatabaseService)
    @objc optional func didFailAddingFlashcard(_ databaseService: DatabaseService, errorMessage: String)
    @objc optional func didAddCategory(_ databaseService: DatabaseService)
    @objc optional func didFailAddingCategory(_ databaseService: DatabaseService, errorMessage: String)
}

class DatabaseService: NSObject {
    override init() {
        self.database = Database.database()
        self.reference = database.reference()
        self.flashcardsRef = reference.child("flashcards")
        self.categoriesRef = reference.child("categories")
        super.init()
    }
    let database: Database!
    let reference: DatabaseReference!
    let flashcardsRef: DatabaseReference!
    let categoriesRef: DatabaseReference!
    
    public weak var delegate: DatabaseServiceDelegate?
}


extension DatabaseService {
    func getAllCategories(fromUserID userID: String, completion: @escaping ([Category]?) -> Void) {
        let categoryRef = categoriesRef.child(userID)
        categoryRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let categoriesSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            
            var categories: [Category] = []
            for categorySnapshot in categoriesSnapshot {
                guard let categoryDict = categorySnapshot.value as? [String : Any] else {
                    print("could not get category dict")
                    completion(nil)
                    return
                }
                guard let category = Category(categoryDict: categoryDict) else {
                    print("could not get category")
                    completion(nil)
                    return
                }
                categories.append(category)
            }
            completion(categories.sortedAlphabetically())
        }
    }
    func getAllFlashcards(forUserID userID: String, andCategoryName categoryName: String, completion: @escaping ([Flashcard]?) -> Void) {
        let flashcardRef = flashcardsRef.child(userID)
        flashcardRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let flashcardsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            
            var flashcards: [Flashcard] = []
            for flashcardSnapshot in flashcardsSnapshot {
                guard let flashcardDict = flashcardSnapshot.value as? [String : Any] else {
                    print("could not get flashcard dict")
                    completion(nil)
                    return
                }
                guard let flashcard = Flashcard(flashcardDict: flashcardDict) else {
                    print("could not get flashcard")
                    completion(nil)
                    return
                }
                
                if flashcard.category != categoryName {
                    continue
                }
                
                flashcards.append(flashcard)
            }
            completion(flashcards.sortedByTimestamp())
        }
    }
}


extension DatabaseService {
    public func addFlashcard(_ flashcard: Flashcard) {
        var flashcard = flashcard
        let flashcardRef = flashcardsRef.child(flashcard.userID).childByAutoId()
        flashcard.flashcardID = flashcardRef.key
        let flashcardJSON = flashcard.toJSON()
        flashcardRef.setValue(flashcardJSON) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingFlashcard?(self, errorMessage: error.localizedDescription)
            } else {
                self.delegate?.didAddFlashcard?(self)
            }
        }
    }
    public func addCategory(_ category: Category) {
        let category = category
        let categoryRef = categoriesRef.child(category.userID).child(category.name)
        let categoryJSON = category.toJSON()
        categoryRef.setValue(categoryJSON) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingCategory?(self, errorMessage: error.localizedDescription)
            } else {
                self.delegate?.didAddCategory?(self)
            }
        }
    }
}
*/
