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
    func getYourData()
    func changeMentoringStatus()
    func deleteAccount()
}

protocol ProfileScreenDataStore {
    //var name: String { get set }
}

class ProfileScreenInteractor: ProfileScreenBusinessLogic, ProfileScreenDataStore {
    
    var presenter: ProfileScreenPresentationLogic?
    var worker: ProfileScreenWorker?
    
    
    // MARK: Do something
    
    func showAuthScreenIfNeeded() {
        let isSignedInWithApple = UserDefaults.standard.bool(forKey: "isSignedInWithApple")
        let isInfoFilled = UserDefaults.standard.bool(forKey: "isInfoFilled")
//        print(isInfoFilled)
//        print(isSignedInWithApple)
        let response = ProfileScreen.chekcAuthAndDataFill.Response(isSignedInWithApple: isSignedInWithApple, isYourInfoFilled: isInfoFilled)
        guard response.isSignedInWithApple != true || response.isYourInfoFilled != true else {return}
        presenter?.presentAuthOrFillDataViewController(response: response)
    }
    func getYourData() {
        let worker1 = ProfileScreenWorker()
        worker1.loadYourData(completion: { [unowned self] responsee in
            presenter?.showYourData(response: responsee)
        }, error: {
            print("инфо о юзере не получена ")
        })

    }
    func changeMentoringStatus() {
        let worker = ChangeMentoringStatusWorker()
        worker.change { [unowned self] changedTo in
            let response = ProfileScreen.ChangeMentoringStatus.Response(changedTo: changedTo)
            presenter?.accountMentoringStatusChanges(response: response)
        }
    }
    
    func deleteAccount() {
        let worker = DeleteAccountWorker()
        worker.delete { [unowned self]  in
            presenter?.accountDeleted()
        }
    }
}
