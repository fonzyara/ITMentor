//
//  FillDataPresenter.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 30.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol FillDataPresentationLogic {
    func presentIsSuccessed(response: FillData.LoadDataOnServer.Response)
    func presentYourData(response: FillData.TransferDataFromProfileToEditScreen.Response)
}

class FillDataPresenter: FillDataPresentationLogic {
    
    weak var viewController: FillDataDisplayLogic?
    
    // MARK: Do something
    
    func presentIsSuccessed(response: FillData.LoadDataOnServer.Response) {
        let viewModel = FillData.LoadDataOnServer.ViewModel(isSuccesed: response.isSuccesed)
        viewController?.displayCompletion(viewModel: viewModel)
    }
    
    func presentYourData(response: FillData.TransferDataFromProfileToEditScreen.Response) {
        let name = response.name
        let discription = response.discription
        let shortDescription = response.shortDiscription
        let imageData = response.imageData
        let languages = response.languages
        let messageLink = response.messageLink
        let viewModel = FillData.TransferDataFromProfileToEditScreen.ViewModel(name: name, discription: discription, imageData: imageData, languages: languages, messageLink: messageLink, shortDiscription: shortDescription)

        viewController?.pasteDataFromProfile(viewMode: viewModel)
    }

}
