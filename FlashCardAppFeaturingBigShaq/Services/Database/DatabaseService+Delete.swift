//
//  DatabaseService+Delete.swift
//  FlashCardAppFeaturingBigShaq
//
//  Created by Richard Crichlow on 2/21/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    /**
     */
    public func deletePost(withPostID postID: String) {
        postsRef.child(postID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingPost?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeletePost?(self, withPostID: postID)
            }
        }
    }
    
    /**
     */
    public func deleteComment(withCommentID commentID: String) {
        commentsRef.child(commentID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingComment?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeleteComment?(self)
            }
        }
    }
    
    
}
