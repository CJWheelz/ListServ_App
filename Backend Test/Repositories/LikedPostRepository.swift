//
//  LikedPostRepository.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/27/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class LikedPostRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var likedPosts = [LikedPost]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("likedposts")
            .order(by: "createdTime", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.likedPosts = querySnapshot.documents.compactMap { document in
                        do {
                            
                            let x = try document.data(as: LikedPost.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func hasLikedPost(post: Post) -> Bool {
        let userID = (Auth.auth().currentUser?.uid)!
        let postID = post.id!
        
        var hasLikedPost = false
        
        for likedPost in likedPosts {
            
            if likedPost.userID == userID {
                
                if likedPost.postID == postID {
                    hasLikedPost = true
                    break
                }
            }
        }
        
        return hasLikedPost
    }
    
    func likePost(post: Post) {
        do {
            let userID = (Auth.auth().currentUser?.uid)!
            
            let likedPost = LikedPost(userID: userID, postID: post.id!)
            
            let _ = try db.collection("likedposts").addDocument(from: likedPost)
        }
        catch {
            fatalError("Unable to add post: \(error.localizedDescription)")
        }
    }
    
    func unlikePost(post: Post) {
        
        let userID = (Auth.auth().currentUser?.uid)!
        
        let postID = (post.id)!
        
        var likedPostID = ""
        
        for likedPost in likedPosts {
            if likedPost.postID == postID && likedPost.userID == userID {
                likedPostID = (likedPost.id)!
                break
            }
        }
        
        db.collection("likedposts").document(likedPostID).delete()
        
        
    }
}
