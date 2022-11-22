//
//  FillDataWorker.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 30.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit
import FirebaseFirestore
import FirebaseStorage
import Firebase

class FillDataWorker {
    func loadToFirebase(name: String?, description: String?, imageData: Data?, languages: [Language], messageLink: String?, shortDescription: String?, completion: @escaping () -> (), error: @escaping () -> ()) {
        guard let yourID = UserDefaults.standard.string(forKey: "ShortUUID") else {error(); return}
        guard InternetConnectionManager.isConnectedToNetwork() == true else {error(); return}
        let ref = Firestore.firestore().collection("Mentors").document(yourID)
        
        let languagesAsString = languages.map { $0.rawValue}
        ref.setData([
            "Name": name as Any,
            "ShortDescription": shortDescription as Any,
            "Description": description as Any,
            "MessageLink": messageLink as Any,
            "Languages": languagesAsString as Any,
        ], merge: true)

        FirebaseImageService.uploadImage(withImage: imageData, userID: yourID) {
            completion()
        } error: {
            error()
        }
        
    }
    
    
    
}
