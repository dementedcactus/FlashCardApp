//
//  DatabaseService+Get.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/21/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DatabaseService {
    
    /** Generates a UserProfile object for the current user from the database.
     
     - Parameters:
     - uid: The unique userID for the current, authenticated user.
     - completion: A closure that executes after a UserProfile is made.
     - userProfile: A UserProfile object for the current user.
     */
    public func getUserProfile(withUID uid: String, completion: @escaping (_ userProfile: UserProfile) -> Void) {
        let ref = usersRef.child(uid)
        ref.observe(.value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName)
            completion(currentUserProfile)
        }
    }
}
