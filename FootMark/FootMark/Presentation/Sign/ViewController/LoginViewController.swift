//
//  SignViewController.swift
//  FootMark
//
//  Created by 박신영 on 3/27/24.
//

import UIKit
import SnapKit
import Then
import Firebase
import KeychainSwift
import AuthenticationServices
import GoogleSignIn

class LoginViewController: BaseViewController, ASAuthorizationControllerDelegate {
   
    // MARK: - Properties
   
   let keychain = KeychainSwift()
   var loginView = LoginView()
   
   override func loadView() {
       view = loginView
   }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("이미 로드됨")
    }
   
   
   override func setAddTarget() {
      // Apple 로그인 버튼
      loginView.appleSignInButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
      
      // Google 로그인 버튼
      loginView.googleSignInButton.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
   }
   
   @objc private func handleGoogleSignIn() {
      print("Google Sign in button tapped")
      
      // Start the sign in flow!
      GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
         guard error == nil else { return }
         guard let signInResult = signInResult else { return }
         
         signInResult.user.refreshTokensIfNeeded { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let idToken = user.idToken?.tokenString
            LoginAPI.shared.getAccessToken(authCode: user.idToken?.tokenString, provider: "google")
            print(idToken!)
         }
      }
   }
   
   @objc private func handleAppleSignIn() {
       let appleIDProvider = ASAuthorizationAppleIDProvider()
       let request = appleIDProvider.createRequest()
       request.requestedScopes = [.fullName, .email]
       let authorizationController = ASAuthorizationController(authorizationRequests: [request])
       authorizationController.delegate = self
       authorizationController.presentationContextProvider = self
       authorizationController.performRequests()
   }
  
   func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
       if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
           guard let appleIDToken = appleIDCredential.identityToken else {
               print("Unable to fetch identity token")
               return
           }
           guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
               print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
               return
           }
           switch authorization.credential {
           case let appleIDCredential as ASAuthorizationAppleIDCredential:
               if  let authorizationCode = appleIDCredential.authorizationCode,
                   let identityToken = appleIDCredential.identityToken,
                   let authCodeString = String(data: authorizationCode, encoding: .utf8),
                   let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                   print("authCodeString: \(authCodeString)")
                   print("identifyTokenString: \(identifyTokenString)")
                   LoginAPI.shared.getAccessToken(authCode: identifyTokenString, provider: "apple")
               }
           default:
               break
           }
       }
   }
   
   func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
       // Handle error.
       print("Sign in with Apple errored: \(error)")
   }
   
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Apple 로그인 인증 창 띄우기
        return self.view.window ?? UIWindow()
    }
}



