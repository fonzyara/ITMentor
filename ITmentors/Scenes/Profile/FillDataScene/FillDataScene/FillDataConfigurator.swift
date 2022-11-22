//
//  FillDataConfigerator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//

import Foundation
class FillDataConfigurator {
    static let shared = FillDataConfigurator()
    
    private init() {}
    
    func configure(with viewController: FillDataViewController) {
        let interactor = FillDataInteractor()
        let presenter = FillDataPresenter()
        let router = FillDataRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
