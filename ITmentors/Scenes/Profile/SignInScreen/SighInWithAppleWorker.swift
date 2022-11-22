import UIKit
import CryptoKit
import AuthenticationServices
import Firebase
import FirebaseFirestore
class SignInWithAppleWorker {
    var shortUUID: String?
    var currentNonce: String?
    
    func startFlow(onViewController: UIViewController) {
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = onViewController as? any ASAuthorizationControllerDelegate
        authorizationController.presentationContextProvider = onViewController as? any ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
        print(3)
    }
    
    
    func loadToFirebaseWith(credential: ASAuthorizationCredential, auth: ASAuthorization, completion: @escaping () -> (), err: @escaping () -> ()){
        if let appleIDCredential = auth.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                err()
                print("Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                err()
                print("Unable to fetch identity token")
                return
            }
            guard let name = appleIDCredential.fullName else {
                err()
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                err()
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credentials = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            FirebaseAuth.loadAppleIDtoFirestore(credential: credentials) { shortUUID in
                print(shortUUID)
                print(123)
                UserDefaults.standard.set(true, forKey: "isSignedInWithApple")
                UserDefaults.standard.set(shortUUID, forKey: "ShortUUID")
                completion()
            }
        }
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
class FirebaseAuth{
    //MARK: - FIREBASE
    static func loadAppleIDtoFirestore(credential: OAuthCredential, completion: @escaping (String) -> ()) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                return
            }

            guard let user = authResult?.user else { return }
//            let email = user.email ?? ""
//            let displayName = user.displayName ?? ""
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let shortUUID = String(uid.prefix(9))
            let ref = Firestore.firestore().collection("Mentors").document(shortUUID)
            
            ref.setData(["AppleUUID": shortUUID], merge: true){ err in
                guard err == nil else {return}
                completion(shortUUID)
            }
        }
        
    }    
}
