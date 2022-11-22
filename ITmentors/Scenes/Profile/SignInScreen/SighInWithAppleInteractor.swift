
import UIKit
import AuthenticationServices

protocol SignInWithAppleBusinessLogic {
    func startFlow(request: SignInWithApple.SignInFlow.Request)
    func loadDataToFirebase(credentials: ASAuthorizationCredential, auth: ASAuthorization)
}

protocol SignInWithAppleDataStore {
    //var name: String { get set }
}

class SignInWithAppleInteractor: SignInWithAppleBusinessLogic, SignInWithAppleDataStore {
    
    var presenter: SignInWithApplePresentationLogic?
    let worker = SignInWithAppleWorker()
    
    // MARK: Do something
    
    func startFlow(request: SignInWithApple.SignInFlow.Request) {
        guard let onVC = request.addRegistarationWindowOnViewController else {return}
        worker.startFlow(onViewController: onVC)
        print(2)
    }
    
    func loadDataToFirebase(credentials: ASAuthorizationCredential, auth: ASAuthorization) {
        worker.loadToFirebaseWith(credential: credentials, auth: auth) { [unowned self] in
            presenter?.goToNextScreen()
        } err: { [unowned self] in
            presenter?.showErrorDataLoading()
        }

        
    }
}
