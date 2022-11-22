//
//  StatisticsInteractor.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 28.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StatisticsBusinessLogic {
    func loadStats()
}

protocol StatisticsDataStore {
}

class StatisticsInteractor: StatisticsBusinessLogic, StatisticsDataStore {
    
    var presenter: StatisticsPresentationLogic?
    var worker: StatisticsWorker?
    
    // MARK: Do something
    
    func loadStats() {
        worker = StatisticsWorker()
        worker?.loadStats(completion: { [unowned self] arrayOfStats in
            // [numberOfProfileViews, numberOfClickThroughs]
            let numberOfProfileViews = arrayOfStats[0]
            let numberOfClickThroughs = arrayOfStats[1]
            var response = Statistics.LoadStats.Response()
            response.numberOfClickThroughs = numberOfClickThroughs
            response.numberOfProfileViews = numberOfProfileViews
            presenter?.presentStats(response: response)

        }, error: {
            print("error of stats loading")
        })
    }
}
