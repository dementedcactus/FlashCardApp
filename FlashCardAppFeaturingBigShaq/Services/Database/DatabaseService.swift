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
        self.cardsRef = self.rootRef.child("cards")
        self.decksRef = self.rootRef.child("decks")
        super.init()
    }
    
    /// The singleton object for the DatabaseService API client.
    static let manager = DatabaseService()
    public weak var delegate: DatabaseServiceDelegate?
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var cardsRef: DatabaseReference!
    var decksRef: DatabaseReference!
    
    /**
     Removes all observers from all references.
     */
    public func stopObserving() {
        rootRef.removeAllObservers()
        usersRef.removeAllObservers()
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

