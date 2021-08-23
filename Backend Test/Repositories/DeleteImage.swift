//
//  DeleteImage.swift
//  Backend Test
//
//  Created by CJ Wheelan on 5/8/21.
//

import Foundation
import Firebase
import FirebaseStorage

func deleteImage(id: String) {
    
    let storage = Storage.storage()
    storage.reference().child(id).delete(completion: { err in
        if let err = err {
            print("Error with deleting image: \(err.localizedDescription)")
        } else {
            print("image deleted successfully!")
        }
    })
    
}
