//
//  Post.swift
//  Backend Test
//
//  Created by CJ Wheelan on 12/31/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var category: String
    var description: String
    var email: String
    var phone: String
    var user: String
    var image: String
}
