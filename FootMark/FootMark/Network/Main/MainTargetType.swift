//
//  MainTargetType.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//


import Foundation
import Moya

enum MainTargetType {
    case getTodo(createAt: String)
   case postCategory(request: PostCategoryRequestModel)
}

extension MainTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getTodo(_):
            return "/category/todos"
           
        case .postCategory(_):
           return "/category"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTodo(_):
            return .get
           
        case .postCategory(_):
           return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTodo(let createAt):
            return .requestParameters(parameters: ["createAt": createAt], encoding: URLEncoding.queryString)
           
        case .postCategory(let request):
           return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getTodo(_):
            return ["Content-Type": "application/json"]
           
        case .postCategory(_):
            return ["Content-Type": "application/json"]
        }
    }
}


