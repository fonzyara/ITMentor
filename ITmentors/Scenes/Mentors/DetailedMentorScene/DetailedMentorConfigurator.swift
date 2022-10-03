//
//  DetailedMentorConfigurator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//

import Foundation
import Foundation
class DetailedMentorConfigurator {
    static let shared = DetailedMentorConfigurator()
    
    private init() {}
    
    func configure(with viewController: DetailedMentorViewController) {
        let interactor = DetailedMentorInteractor()
        let presenter = DetailedMentorPresenter()
        let router = DetailedMentorRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
