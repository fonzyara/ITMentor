//
//  FillDataModels.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 30.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum FillData {
    // MARK: Use cases
    
    enum LoadDataOnServer {
        struct Request {
            var name: String?
            var discription: String?
            var imageData: Data?
            var languages: [Language]
            var messageLink: String?
            var shortDiscription: String?
        }
        
        struct Response {
            var isSuccesed: Bool?
        }
        
        struct ViewModel {
            var isSuccesed: Bool?
        }
    }
    enum TransferDataFromProfileToEditScreen{
        struct Response {
            var name: String?
            var discription: String?
            var imageData: Data?
            var languages: [Language]
            var messageLink: String?
            var shortDiscription: String?
        }
        
        struct ViewModel {
            var name: String?
            var discription: String?
            var imageData: Data?
            var languages: [Language]
            var messageLink: String?
            var shortDiscription: String?
        }
    }
}
