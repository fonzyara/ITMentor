//
//  SignInWithAppleViewModel.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 03.10.2022.
//
import Firebase
import CryptoKit
import FirebaseAuth
import UIKit
import AuthenticationServices
import FirebaseFirestore

protocol SignInWithAppleViewModelProtocol: AnyObject {
    func startFlow(vc: UIViewController)
    func loadAppleIDtoFirestore(credential: OAuthCredential, vc: SignInWithAppleViewController, completion: @escaping () -> ())
    var shortUUID: String? {get set}
    var currentNonce: String? {get set}
}



class SignInWithAppleViewModel: SignInWithAppleViewModelProtocol {
    var shortUUID: String?
    
 
    
    func loadAppleIDtoFirestore(credential: OAuthCredential, vc: SignInWithAppleViewController, completion: @escaping () -> ()) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                return
            }
            
            print("lol")
            
            guard let user = authResult?.user else { return }
            let email = user.email ?? ""
            let displayName = user.displayName ?? ""
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let shortUUID = uid.prefix(9)
            self.shortUUID = String(shortUUID)
            let ref = Firestore.firestore().collection("Mentors").document(String(shortUUID))
            
            ref.setData(["AppleUUID": shortUUID], merge: true){ err in
                if let err = err {
                    vc.showErrorAlert(error: err)
                }
                else{completion()}
            }
        }

    }
    
    var currentNonce: String?
    
    func startFlow(vc: UIViewController) {
        if InternetConnectionManager.isConnectedToNetwork(){
            let nonce = randomNonceString()
            currentNonce = nonce
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            request.nonce = sha256(nonce)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = vc as! any ASAuthorizationControllerDelegate
            authorizationController.presentationContextProvider = vc as! any ASAuthorizationControllerPresentationContextProviding
            authorizationController.performRequests()
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
