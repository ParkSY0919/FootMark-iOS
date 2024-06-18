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
   
   let loginServiceWithAccessToken: LoginServiceWithAccessToken = LoginServiceWithAccessToken()
   let loginService: LoginService = LoginService()
   let emojiService: EmojiService = EmojiService()
   let mainService: MainService = MainService()
    let todoService: TodoService = TodoService()
    let reviewService: ReviewService = ReviewService()
}
