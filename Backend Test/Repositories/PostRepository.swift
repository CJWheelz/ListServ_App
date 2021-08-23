//
//  PostRepository.swift
//  Backend Test
//
//  Created by CJ Wheelan on 12/31/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var posts = [Post]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("posts")
            .order(by: "createdTime", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.posts = querySnapshot.documents.compactMap { document in
                    do {
                        
                        let x = try document.data(as: Post.self)
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
    
    func addPost(_ post: Post) {
        do {
            let _ = try db.collection("posts").addDocument(from: post)
        }
        catch {
            fatalError("Unable to add post: \(error.localizedDescription)")
        }
    }
    
    func updatePost(_ post: Post) {
        
        if let postID = post.id {
//            print("Entered the if statement")
            do {
                try db.collection("posts").document(postID).setData(from: post)
            }
            catch {
                fatalError("Couldn't update post: \(error.localizedDescription)")
            }
        }
    }
    
    func deletePost(_ post: Post) {
        
        if let postID = post.id {
            
            db.collection("posts").document(postID).delete()
        }
        
    }
}
