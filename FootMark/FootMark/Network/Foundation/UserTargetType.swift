//
//  API.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import Foundation
import Moya


enum UserTargetType {
   
   //MARK: - Login
   case socialLogin(provider: String, request: LoginRequestModel)
   
}

extension UserTargetType: TargetType {
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


