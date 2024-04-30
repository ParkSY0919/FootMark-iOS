//
//  LoginRouter.swift
//  FootMark
//
//  Created by 박신영 on 5/1/24.
//

import Foundation
import Moya

enum LoginRouter {
   
   //MARK: - Login
   case socialLogin(provider: String, request: LoginRequestModel)
   
}

extension LoginRouter: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
   var path: String {
      switch self {
      case .socialLogin(let provider, _):
         return "/oauth/\(provider)/token"
         
      }
   }
    
    var method: Moya.Method {
        switch self {
        case .socialLogin(_, _):
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogin(_, let request):
           return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .socialLogin(_, _):
           return ["Content-Type": "application/json"]
        }
        
    }
}
