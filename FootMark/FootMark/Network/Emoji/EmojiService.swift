//
//  EmojiService.swift
//  FootMark
//
//  Created by 박신영 on 6/9/24.
//

import Foundation

import Moya
import KeychainSwift

protocol EmojiServiceProtocol {
   func postEmoji(request: PostEmojiRequestModel, completion: @escaping (NetworkResult<PostEmojiDTO>) -> Void)
}

let keychain = KeychainSwift()
let accessToken = keychain.get("accessToken")

let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
   do {
      var request = try endpoint.urlRequest()
      // 헤더에 accessToken 추가
      request.addValue("Bearer \(accessToken ?? "accessToken 없음")", forHTTPHeaderField: "Authorization")
      // 수정된 요청을 완료 클로저에 전달
      done(.success(request))
   } catch {
      done(.failure(MoyaError.underlying(error, nil)))
   }
}

final class EmojiService: BaseService, EmojiServiceProtocol {
   
   let moyaProvider = MoyaProvider<EmojiTargetType>(requestClosure: requestClosure, plugins: [MoyaLoggingPlugin()])
   
   func postEmoji(request: PostEmojiRequestModel, completion: @escaping (NetworkResult<PostEmojiDTO>) -> Void) {
      moyaProvider.request(.addEmoji(request: request)) { result in
         switch result {
         case .success(let result):
            let statusCode = result.statusCode
            let data = result.data
            
            let networkResult: NetworkResult<PostEmojiDTO> = self.judgeStatus(statusCode: statusCode, data: data)
            completion(networkResult)
            
         case .failure:
            completion(.networkFail)
         }
      }
   }
   
}

