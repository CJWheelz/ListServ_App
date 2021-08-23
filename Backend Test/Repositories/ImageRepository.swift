//
//  ImageRepository.swift
//  Backend Test
//
//  Created by CJ Wheelan on 4/26/21.
//

import Foundation
import Firebase
import FirebaseStorage

class ImageRepository: ObservableObject {
    @Published var image: UIImage?
    
    init(id: String) {
        Storage.storage().reference().child(id).getData(maxSize: 10 * 1024*1024) { (data, err) in
            if let err = err {
                print("Error: \(err.localizedDescription)")
            }
            else {
                if let imageData = data {
                    self.image = UIImage(data: imageData)
                }
                else {
                    print("couldn't unwrap image data")
                }
                print("downloaded image successfully")
            }
        }
    }
}
