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
      print("로드됨")
   }
   
   // MARK: - setAddTarget
   override func setAddTarget() {
      // Apple 로그인 버튼
      loginView.appleSignInButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
      
      // Google 로그인 버튼
      loginView.googleSignInButton.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
   }
   
   func socialLogin(provider: String, idToken: String) {
      NetworkService.shared.loginService.postSocialLogin(
         provider: provider,
         request: LoginRequestModel(authCode: idToken)) { result in
            switch result {
            case .success(let loginDTO):
               print("\(provider) 로그인 성공")
               print("AccessToken: \(loginDTO.data.accessToken)")
               print("refreshToken: \(loginDTO.data.refreshToken)")
               let keychain = KeychainSwift()
               keychain.set(loginDTO.data.accessToken, forKey: "accessToken")
               keychain.set(loginDTO.data.refreshToken, forKey: "refreshToken")
            case .tokenExpired(let dat):
               print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
               self.getNewAccessToken()
            case .requestErr:
               print("요청 오류입니다")
            case .decodedErr:
               print("디코딩 오류입니다")
            case .pathErr:
               print("경로 오류입니다")
            case .serverErr:
               print("서버 오류입니다")
            case .networkFail:
               print("네트워크 오류입니다")
            }
         }
   }
   
   func getNewAccessToken() {
      guard let refreshToken = self.keychain.get("refreshToken") else {
         print("No refreshToken found in keychain.")
         return
      }
      
      NetworkService.shared.loginService.postRefreshToken(refreshToken: refreshToken) {
         result in
         switch result {
         case .success(let loginDTO):
            print("재발급 로그인 성공")
            print("AccessToken: \(loginDTO.data.accessToken)")
            print("refreshToken: \(loginDTO.data.refreshToken)")
            let keychain = KeychainSwift()
            keychain.set(loginDTO.data.accessToken, forKey: "accessToken")
            keychain.set(loginDTO.data.refreshToken, forKey: "refreshToken")
         case .tokenExpired(_):
            print("refresh 토큰 만료입니다")
         case .requestErr:
            print("요청 오류입니다")
         case .decodedErr:
            print("디코딩 오류입니다")
         case .pathErr:
            print("경로 오류입니다")
         case .serverErr:
            print("서버 오류입니다")
         case .networkFail:
            print("네트워크 오류입니다")
         
         }
      }
   }
   
   func authorizationController(
      controller: ASAuthorizationController,
      didCompleteWithAuthorization authorization: ASAuthorization) {
         if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let appleIDToken = appleIDCredential.identityToken else {
               print("Unable to fetch identity token")
               return
            }
            guard String(data: appleIDToken, encoding: .utf8) != nil else {
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
                  self.socialLogin(provider: "apple", idToken: identifyTokenString)
               }
            default:
               break
            }
         }
      }
   
   func authorizationController(
      controller: ASAuthorizationController,
      didCompleteWithError error: Error) {
         print("Sign in with Apple errored: \(error)")
      }
   
   // MARK: - @objc func
   @objc private func handleGoogleSignIn() {
      print("Google Sign in button tapped")
      GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
         guard error == nil else { return }
         guard let signInResult = signInResult else { return }
         
         signInResult.user.refreshTokensIfNeeded { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let idToken = user.idToken?.tokenString
            print("현재 idToken: \(idToken!)")
            self.socialLogin(provider: "google", idToken: idToken ?? "")
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
   
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
   
   // Apple 로그인 인증 창 띄우기
   func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
      return self.view.window ?? UIWindow()
   }
   
}
