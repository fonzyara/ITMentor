//
//  BecomeMentorConfigerator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//

import Foundation
class BecomeMentorConfigurator {
    static let shared = BecomeMentorConfigurator()
    
    private init() {}
    
    func configure(with viewController: BecomeMentorViewController) {
        let interactor = BecomeMentorInteractor()
        let presenter = BecomeMentorPresenter()
        let router = BecomeMentorRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
