//
//  LoginTargetType.swift
//  FootMark
//
//  Created by 박신영 on 5/31/24.
//

import Foundation
import Moya

enum LoginTargetType {
   case socialLogin(provider: String, request: LoginRequestModel)
   case newAccessToken(refreshToken: String)
   case isFirstLogin
}

extension LoginTargetType: BaseTargetType {
   
   var baseURL: URL {
      return URL(string: Config.baseURL)!
   }
   
   var path: String {
      switch self {
      case .socialLogin(let provider, _):
         return "/oauth/\(provider)/token"
         
      case .newAccessToken(_):
         return "/api/access"
         
      case .isFirstLogin:
         return "/member/success"
      }
   }
   
   var method: Moya.Method {
      switch self {
      case .socialLogin(_, _):
         return .post
         
      case .newAccessToken:
         return .post
         
      case .isFirstLogin:
         return .get
      }
   }
   
   var task: Moya.Task {
      switch self {
      case .socialLogin(_, let request):
         return .requestJSONEncodable(request)
         
      case .newAccessToken:
         return .requestPlain
         
      case .isFirstLogin:
         return .requestPlain
      }
   }
   
   var headers: [String : String]? {
      switch self {
      case .socialLogin(_, _):
         return ["Content-Type": "application/json"]
         
      case .newAccessToken:
         return ["Content-Type": "application/json"]
         
      case .isFirstLogin:
         return ["Content-Type": "application/json"]
         
      }
      
   }
}



