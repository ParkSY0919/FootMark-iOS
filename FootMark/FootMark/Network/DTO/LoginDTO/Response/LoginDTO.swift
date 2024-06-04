//
//  LoginDTO.swift
//  FootMark
//
//  Created by 박신영 on 4/16/24.
//

import Foundation

// MARK: - LoginDTO
struct LoginDTO: Codable {
    let statusCode: Int
    let message: String
    let data: LoginDataClass
   
   init(statusCode: Int, message: String, data: LoginDataClass) {
      self.statusCode = statusCode
      self.message = message
      self.data = data
   }
}

// MARK: - LoginDataClass
struct LoginDataClass: Codable {
    let accessToken, refreshToken: String
   
   init(accessToken: String, refreshToken: String) {
      self.accessToken = accessToken
      self.refreshToken = refreshToken
   }
}
