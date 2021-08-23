//
//  UploadImage.swift
//  Backend Test
//
//  Created by CJ Wheelan on 5/7/21.
//

import Foundation
import Firebase
import FirebaseStorage

func uploadImage(id: String, image: UIImage) {
    if let imageData = image.jpegData(compressionQuality: 1) {
        let storage = Storage.storage()
        storage.reference().child(id).putData(imageData, metadata: nil) { (data, err) in
            if let err = err {
                print("error: \(err.localizedDescription)")
            } else {
                print("image uploaded successfully!")
            }
        }
    }
    else {
        print("Error: couldn't unwrap/case image to data")
    }
}
