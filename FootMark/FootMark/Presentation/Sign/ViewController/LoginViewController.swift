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
   
}

