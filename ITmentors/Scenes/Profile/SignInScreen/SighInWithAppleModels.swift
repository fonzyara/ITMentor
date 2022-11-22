
import UIKit
import AuthenticationServices

enum SignInWithApple {
    // MARK: Use cases
    
    enum SignInFlow {
        struct Request {
            var addRegistarationWindowOnViewController: UIViewController?
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
    
    enum loadDataToFirebase{
        struct Request{
            var credentials: ASAuthorizationAppleIDCredential?
            var authorization: ASAuthorization
        }
        
    }
}
