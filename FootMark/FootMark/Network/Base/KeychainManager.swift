//
//  KeychainManager.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//


import Foundation
import Moya
import KeychainSwift

class KeychainManager {
   static let shared = KeychainManager()
   private let keychain = KeychainSwift()
   
   private init() {}
   
   func getAccessToken() -> String? {
//      let accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaW55b3VuZzQwOEBnbWFpbC5jb20iLCJhdXRoIjoiUk9MRV9VU0VSIiwiaWF0IjoxNzE4NzMzNzU1LCJleHAiOjE3MTg3MzczNTV9.ea8SK9y8VIJzJOsGtTpB3hzFSOxyr-PZGeerwLeagDNnZD8MUUswuBQXNl3qp3dMX8cWWOB8so-qBCWUEnd1vw"
//      keychain.set(accessToken, forKey: "accessToken")
      return keychain.get("accessToken")
   }
   
   func removeAccessToken() {
      keychain.delete("accessToken")
   }
   
   //MARK: - Moya accessToken 클로저
   
   func loginTargetRequestClosure() -> MoyaProvider<LoginTargetType>.RequestClosure {
      return { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
         do {
            var request = try endpoint.urlRequest()
            if let accessToken = self.getAccessToken() {
               request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            } else {
               request.addValue("accessToken 없음", forHTTPHeaderField: "Authorization")
            }
            done(.success(request))
         } catch {
            done(.failure(MoyaError.underlying(error, nil)))
         }
      }
   }
   
   func mainTargetRequestClosure() -> MoyaProvider<MainTargetType>.RequestClosure {
      return { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
         do {
            var request = try endpoint.urlRequest()
            if let accessToken = self.getAccessToken() {
               request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            } else {
               request.addValue("accessToken 없음", forHTTPHeaderField: "Authorization")
            }
            done(.success(request))
         } catch {
            done(.failure(MoyaError.underlying(error, nil)))
         }
      }
   }
   
    func createRequestClosure() -> MoyaProvider<TodoTargetType>.RequestClosure {
        return { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                if let accessToken = self.getAccessToken() {
                    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                } else {
                    request.addValue("accessToken 없음", forHTTPHeaderField: "Authorization")
                }
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
}

