//
//  LoginService.swift
//  FootMark
//
//  Created by 박신영 on 5/31/24.
//

import Foundation

import Moya

protocol LoginServiceProtocol {
   func postSocialLogin(provider: String, request: LoginRequestModel, completion: @escaping (NetworkResult<LoginDTO>) -> Void)
   func postRefreshToken(refreshToken: String, completion: @escaping (NetworkResult<LoginDTO>) -> Void)
}

final class LoginService: BaseService, LoginServiceProtocol {
   
   let moyaProvider = MoyaProvider<LoginTargetType>(plugins: [MoyaLoggingPlugin()])
   
   func postSocialLogin(provider: String, request: LoginRequestModel, completion: @escaping (NetworkResult<LoginDTO>) -> Void) {
      moyaProvider.request(.socialLogin(provider: provider, request: request)) { result in
         switch result {
         case .success(let result):
            let statusCode = result.statusCode
            let data = result.data
            
            let networkResult: NetworkResult<LoginDTO> = self.judgeStatus(statusCode: statusCode, data: data)
            completion(networkResult)
            
         case .failure:
            completion(.networkFail)
         }
      }
   }
   
   func postRefreshToken(refreshToken: String, completion: @escaping (NetworkResult<LoginDTO>) -> Void) {
      moyaProvider.request(.newAccessToken(refreshToken: refreshToken)) { result in
         switch result {
         case .success(let result):
            let statusCode = result.statusCode
            let data = result.data
            
            let networkResult: NetworkResult<LoginDTO> = self.judgeStatus(statusCode: statusCode, data: data)
            completion(networkResult)
            
         case .failure:
            completion(.networkFail)
         }
      }
   }
   
   
}
