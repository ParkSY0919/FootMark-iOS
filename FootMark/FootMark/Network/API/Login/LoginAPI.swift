//
//  LoginAPI.swift
//  FootMark
//
//  Created by 박신영 on 4/16/24.
//

import Alamofire
import UIKit
import KeychainSwift

final class LoginAPI : BaseAPI {
    static let shared = LoginAPI()
    var loginVC = LoginViewController()
    let keychain = KeychainSwift()
    private override init() {}
}

extension LoginAPI {
   
   // MARK: - 소셜로그인
   
   public func SocialSignin(authCode: String?, provider: String) {
      
   }
   
    var baseURL: String { return Config.baseURL }
    // 로그인 API
    
   public func getAccessToken(authCode: String?, provider: String) {
         let headers: HTTPHeaders = [
            "Accept": "application/json"
         ]
         // Body 설정
         let parameters: Parameters = [
            "authCode" : authCode!,
         ]
         AF.request("\(baseURL)/oauth/\(provider)/token", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300)
            .responseDecodable(of: LoginDTO.self) { response in
               switch response.result {
               case .success(let loginDTO):
                  print("\(provider) 로그인 성공")
                  print("AccessToken: \(loginDTO.data.accessToken)")
                  print("refreshToken: \(loginDTO.data.refreshToken)")
                  let keychain = KeychainSwift()
                  keychain.set(loginDTO.data.accessToken, forKey: "accessToken")
                  keychain.set(loginDTO.data.refreshToken, forKey: "refreshToken")
                  
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400:  // 기존 회원
                            print("로그인 실패")
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "로그인 실패", message: "해당 이메일로 이미 가입한 계정이 있습니다.\n다른 소셜 플랫폼에서 가입하였다면, 해당 플랫폼을 통해 로그인을 시도해주십시오.", preferredStyle: .alert)
                                let action = UIAlertAction(title: "확인", style: .default)
                                alertController.addAction(action)
                                
                                // 현재 활성화된 뷰 컨트롤러를 찾아서 알림창을 띄웁니다.
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let delegate = windowScene.delegate as? SceneDelegate,
                                   let window = delegate.window,
                                   let viewController = window.rootViewController {
                                    viewController.present(alertController, animated: true, completion: nil)
                                }
                            }
                        case 401:  // 인증 실패
                            print("로그인 실패: 인증 실패")
                        case 404:
                            print("로그인 실패: Email Not Found")
//                            DispatchQueue.main.async {
//                                let alertController = UIAlertController(title: "로그인 실패", message: "Github 이메일이 존재하지 않습니다.\n다른 플랫폼을 이용한 로그인 혹은 Github 이메일을 등록 후 시도해주세요", preferredStyle: .alert)
//                                let action = UIAlertAction(title: "확인", style: .default)
//                                alertController.addAction(action)
//                                
//                                // 현재 활성화된 뷰 컨트롤러를 찾아서 알림창을 띄웁니다.
//                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                                   let delegate = windowScene.delegate as? SceneDelegate,
//                                   let window = delegate.window,
//                                   let viewController = window.rootViewController {
//                                    viewController.present(alertController, animated: true, completion: nil)
//                                }
//                            }
                            
                        case 500...599:  // 서버 에러
                            print("로그인 실패: 서버 에러")
                        default:
                            print("로그인 실패: 알 수 없는 에러")
                        }
                    }
                    
                }
            }
    }
   
   
    public func refreshAccessToken(completion: @escaping (Result<LoginDTO, Error>) -> Void){
        let keychain = KeychainSwift()
        guard let refreshToken = keychain.get("refreshToken") else {
            print("No refreshToken found in keychain.")
            return
        }
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        // Body 설정
        let parameters: Parameters = [
            "refreshToken" : refreshToken,
        ]
        AF.request("\(baseURL)/api/token/access", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300)
            .responseDecodable(of: LoginDTO.self) { response in
                switch response.result {
                case .success(let loginDTO):
                    print("재발급 로그인 성공")
                    print("AccessToken: \(loginDTO.data.accessToken)")
                    print("refreshToken: \(loginDTO.data.refreshToken)")
                    let keychain = KeychainSwift()
                    keychain.set(loginDTO.data.accessToken, forKey: "accessToken")
                    keychain.set(loginDTO.data.refreshToken, forKey: "refreshToken")
                    completion(.success(loginDTO))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400...499:  // 클라이언트 에러
                            print("로그인 실패: 클라이언트 에러")
                        case 500...599:  // 서버 에러
                            print("로그인 실패: 서버 에러")
                        default:
                            print("로그인 실패: 알 수 없는 에러")
                        }
                    }
                    completion(.failure(error))
                }
            }
    }
}
