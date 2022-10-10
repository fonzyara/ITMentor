//
//  ProfileScreenConfigurator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//

import Foundation

class ProfileMentorConfigurator {
    static let shared = ProfileMentorConfigurator()
    
    private init() {}
    
    func configure(with viewController: ProfileScreenViewController) {
        let interactor = ProfileScreenInteractor()
        let presenter = ProfileScreenPresenter()
        let router = ProfileScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
