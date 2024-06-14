//
//  EmojiTargetType.swift
//  FootMark
//
//  Created by 박신영 on 6/9/24.
//

import Foundation
import Moya

enum EmojiTargetType {
   case addEmoji(request: PostEmojiRequestModel)
}

extension EmojiTargetType: BaseTargetType {
   
   var baseURL: URL {
      return URL(string: Config.baseURL)!
   }
   
   var path: String {
      switch self {
      case .addEmoji(_):
         return "/emoji"
      }
   }
   
   var method: Moya.Method {
      switch self {
      case .addEmoji(_):
         return .post
      }
   }
   
   var task: Moya.Task {
      switch self {
      case .addEmoji(let request):
         return .requestJSONEncodable(request)
      }
   }
   
   var headers: [String : String]? {
      switch self {
      case .addEmoji(_):
         return ["Content-Type": "application/json"]
         
      }
      
   }
}

