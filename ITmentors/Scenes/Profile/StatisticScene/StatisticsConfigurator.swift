//
//  StatisticsConfugirator.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 28.10.2022.
//

import Foundation
class StatisticsConfigurator {
    static let shared = StatisticsConfigurator()
    
    private init() {}
    
    func configure(with viewController: StatisticsViewController) {
        let interactor = StatisticsInteractor()
        let presenter = StatisticsPresenter()
        let router = StatisticsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
