
import UIKit

protocol SignInWithApplePresentationLogic {
    func showErrorDataLoading()
    func goToNextScreen()
}

class SignInWithApplePresenter: SignInWithApplePresentationLogic {
    
    weak var viewController: SignInWithAppleDisplayLogic?
    
    // MARK: Do something
    
    func showErrorDataLoading(){
        viewController?.showErrorDataLoading()
    }
    func goToNextScreen() {
        viewController?.goToNextScreen()
    }
}
