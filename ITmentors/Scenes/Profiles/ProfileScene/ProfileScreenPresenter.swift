//
//  ProfileScreenPresenter.swift
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

protocol ProfileScreenPresentationLogic {
    func presentSomething(response: ProfileScreen.Something.Response)
}

class ProfileScreenPresenter: ProfileScreenPresentationLogic {
    
    weak var viewController: ProfileScreenDisplayLogic?
    
    // MARK: Do something
    func presentSomething(response: ProfileScreen.Something.Response) {
        var viewModel: ProfileScreen.Something.ViewModel?
        if response.isSignedInWithApple == false {
            viewModel = ProfileScreen.Something.ViewModel(viewControllerWeNeedToShow: SignInWithAppleViewController())
        }
        else if response.isYourInfoFilled == false {
            viewModel = ProfileScreen.Something.ViewModel(viewControllerWeNeedToShow: BecomeMentorViewController())
        }
        viewController?.showAuthOrFillInfoScreen(viewModel: viewModel)
    }
}
