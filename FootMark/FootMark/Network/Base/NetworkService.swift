//
//  NetworkService.swift
//  FootMark
//
//  Created by 박신영 on 5/31/24.
//

import Foundation

final class NetworkService {
   
   static let shared = NetworkService()
   
   private init() {}
   
   let loginService: LoginService = LoginService()
}
