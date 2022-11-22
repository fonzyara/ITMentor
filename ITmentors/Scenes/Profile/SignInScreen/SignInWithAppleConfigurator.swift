
import Foundation
class SignInWithAppleConfigurator{
    static let shared = SignInWithAppleConfigurator()
    
    private init() {}
    
    func configure(with viewController: SignInWithAppleViewController) {
        let interactor = SignInWithAppleInteractor()
        let presenter = SignInWithApplePresenter()
        let router = SignInWithAppleRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
