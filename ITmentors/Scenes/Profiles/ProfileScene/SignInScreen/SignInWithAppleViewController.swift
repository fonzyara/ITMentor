//
//  SignInWithAppleViewController.swift
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



class SignInWithAppleViewController: UIViewController {
    var viewModel: SignInWithAppleViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInWithAppleViewModel()
        addSubviews()

    }

    private let appleButton : ASAuthorizationAppleIDButton = {
        let appleButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        appleButton.cornerRadius = 12
        appleButton.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
        return appleButton
    }()
    
    private let mentorImage: UIImageView = {
        let i = UIImageView(image: UIImage(named: "mentorImage"))
       return i
    }()
    private let label: UILabel = {
        let l = UILabel()
        l.text = "Чтобы стать ментором, необходимо войти в аккаунт через AppleID"
        l.textColor = .white
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
      return l
    }()
    
    @objc func startSignInWithAppleFlow() {
        viewModel?.startFlow(vc: self)
    }
}
extension SignInWithAppleViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print(123)
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = viewModel?.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let name = appleIDCredential.fullName else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            viewModel?.loadAppleIDtoFirestore(credential: credential, vc: self, completion: { [unowned self] in
                UserDefaults.standard.set(true, forKey: "isSignedInWithApple")
                guard let id = viewModel?.shortUUID else {return}
                UserDefaults.standard.set(id, forKey: "ShortUUID")

                let nextVC = BecomeMentorViewController()
                nextVC.isBackButtonHidden = true
                show(nextVC, sender: self)
            })
            
            
        }
    }
    //https://t.me/escaping_closure
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        showErrorAlert(error: error)
    }
}

extension SignInWithAppleViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


extension SignInWithAppleViewController {
    func addSubviews(){
        title = "Вход/регистрация"
        view.backgroundColor = .AppPalette.backgroundColor
        navigationItem.hidesBackButton = true
        
        view.addSubview(appleButton)
        view.addSubview(label)
        view.addSubview(mentorImage)
    
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-30)
        }
        
        mentorImage.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(mentorImage.snp.width)
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(mentorImage.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
    }
}

extension SignInWithAppleViewController{
    func showErrorAlert(error: Error){
        let dialogMessage = UIAlertController(title: "Ошибка", message: "\(error)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Что ж :(", style: .default)
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true)

    }
}
