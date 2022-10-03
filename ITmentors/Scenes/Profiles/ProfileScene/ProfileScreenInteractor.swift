//
//  ProfileScreenInteractor.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 27.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProfileScreenBusinessLogic {
    func showAuthScreenIfNeeded()
}

protocol ProfileScreenDataStore {
    //var name: String { get set }
}

class ProfileScreenInteractor: ProfileScreenBusinessLogic, ProfileScreenDataStore {
    
    var presenter: ProfileScreenPresentationLogic?
    var worker: ProfileScreenWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func showAuthScreenIfNeeded() {
        worker = ProfileScreenWorker()
        worker?.doSomeWork()
        
        let isSignedInWithApple = UserDefaults.standard.bool(forKey: "isSignedInWithApple")
        let isInfoFilled = UserDefaults.standard.bool(forKey: "isInfoFilled")
        let response = ProfileScreen.Something.Response(isSignedInWithApple: isSignedInWithApple, isYourInfoFilled: isInfoFilled)
        presenter?.presentSomething(response: response)
    }
}
