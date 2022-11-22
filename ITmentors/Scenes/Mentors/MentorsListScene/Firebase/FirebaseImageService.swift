//
//  FirebaseImageService.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 21.11.2022.
//

import FirebaseStorage
import UIKit
class FirebaseImageService{
    static func loadImage(userID: String, completion: @escaping (Data?) -> ()){
        let ref = Storage.storage().reference().child("avatars").child(userID)
        ref.getData(maxSize: 1024 * 1024 ) { data, error in
            guard error == nil else {return}
            guard let imageData = data else {return}
            completion(imageData)
        }
    }

    static func uploadImage(withImage: Data?, userID: String, completion: @escaping () -> (), error: @escaping () -> ()){
        let ref = Storage.storage().reference().child("avatars").child(userID)
        guard let data = withImage else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        guard let photo1 = UIImage(data: data) else {return}
        guard let photo = photo1.jpegData(compressionQuality: 0.4) else {return}
        
        
        ref.putData(photo, metadata: metadata) { (metadata, err) in
            guard err == nil else {error(); return}
            completion()
        }

    }
}

