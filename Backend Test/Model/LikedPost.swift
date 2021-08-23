//
//  LikedPost.swift
//  Backend Test
//
//  Created by CJ Wheelan on 1/27/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LikedPost: Codable, Identifiable {
    @DocumentID var id: String?
    var userID: String
    var postID: String
    @ServerTimestamp var createdTime: Timestamp?
}
