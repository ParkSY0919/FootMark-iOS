//
//  ReviewTargetType.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation
import Moya

enum ReviewTargetType {
    case addReview(request: PostReviewRequestModel)
    case editReview(reviewId: Int, request: PutReviewRequestModel)
    case delReview(reviewId: Int)
}

extension ReviewTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addReview(_):
            return "/review"
            
        case .editReview(let reviewId, _):
            return "/review/\(reviewId)"
            
        case .delReview(let reviewId):
            return "/review/\(reviewId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addReview(_):
            return .post
            
        case .editReview(let reviewId, _):
            return .put
            
        case .delReview(let reviewId):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addReview(let request):
            return .requestJSONEncodable(request)
            
        case .editReview(_, let request):
            return .requestJSONEncodable(request)
            
        case .delReview(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .addReview(_):
            return ["Content-Type": "application/json"]
            
        case .editReview(_, _):
            return ["Content-Type": "application/json"]
            
        case .delReview(_):
            return ["Content-Type": "application/json"]
        }
    }
}

