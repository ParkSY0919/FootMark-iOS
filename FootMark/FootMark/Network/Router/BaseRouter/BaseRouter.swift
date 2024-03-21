//
//  BaseRouter.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import Foundation

//MARK: - 아래 로그인 라우터 예시

/*
enum LoginRouter {
   case getCheckInitialLogin(token: String)
}

extension LoginRouter: BaseTargetType {
   var baseURL: String { return Config.baseURL }
   
   var method: HTTPMethod {
      switch self {
      case .getCheckInitialLogin:
         return .get
      }
   }
   
   var path: String {
      switch self {
      case .getCheckInitialLogin:
         return "/api/success"
      }
   }
   
   var parameters: RequestParams {
      switch self {
      case .getCheckInitialLogin:
         return .none
      }
   }
   
   var headers : HTTPHeaders?{
      switch self{
      case .getCheckInitialLogin(let token):
         return ["Authorization": "Bearer \(token)"]
      }
   }
}
*/
