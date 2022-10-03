//
//  MentorListconfigurator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//

import Foundation
class MentorsListConfigurator {
    static let shared = MentorsListConfigurator()
    
    private init() {}
    
    func configure(with viewController: MentorsScreenViewController) {
        let interactor = MentorsScreenInteractor()
        let presenter = MentorsScreenPresenter()
        let router = MentorsScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
