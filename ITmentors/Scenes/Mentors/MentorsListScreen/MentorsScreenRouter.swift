//
//  MentorsScreenRouter.swift
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
typealias MentorCellViewModel = MentorsScreen.ShowMentorCells.ViewModel.MentorCellViewModel
protocol MentorsScreenRoutingLogic {
    func navigateToDetailed(source: MentorsScreenViewController, destination: DetailedMentorViewController, withData: MentorCellViewModel)
}

protocol MentorsScreenDataPassing {
    var dataStore: MentorsScreenDataStore? { get }
}

class MentorsScreenRouter: NSObject, MentorsScreenRoutingLogic, MentorsScreenDataPassing {
    
    
    
    weak var viewController: MentorsScreenViewController?
    var dataStore: MentorsScreenDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    func navigateToDetailed(source: MentorsScreenViewController, destination: DetailedMentorViewController, withData: MentorCellViewModel) {
      source.show(destination, sender: nil)
//        destination.showMentorInfo(viewModel: withData as? DetailedMentor.ShowMentorInfo.ViewModel)
        guard var detailDS = destination.router?.dataStore else {return}
        passDataToDetailed(destination: &detailDS, withData: withData)
    }
    
    // MARK: Passing data
    
    func passDataToDetailed(destination: inout DetailedMentorDataStore, withData: MentorCellViewModel) {
        destination.name = withData.name
        destination.discription = withData.discription
        destination.imageData = withData.imageData
        destination.languages = withData.languages
        destination.messageLink = withData.messageLink
        destination.shortDiscription = withData.shortDiscription
        
    }
}