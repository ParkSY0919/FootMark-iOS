//
//  ReviewService.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation
import Moya
import KeychainSwift

protocol ReviewServiceProtocol {
    func postReview(request: PostReviewRequestModel, completion: @escaping (NetworkResult<PostReviewDTO>) -> Void)
    func putReview(reviewId: Int ,request: PutReviewRequestModel, completion: @escaping (NetworkResult<PutReviewDTO>) -> Void)
    func delReview(reviewId: Int, completion: @escaping (NetworkResult<DelReviewDTO>) -> Void)
}

final class ReviewService: BaseService, ReviewServiceProtocol {
    let moyaProvider: MoyaProvider<ReviewTargetType>
    
    override init() {
        self.moyaProvider = MoyaProvider<ReviewTargetType>(
            requestClosure: KeychainManager.shared.createRequestClosure(),
            plugins: [MoyaLoggingPlugin()]
        )
        super.init()
    }
    
    func postReview(request: PostReviewRequestModel, completion: @escaping (NetworkResult<PostReviewDTO>) -> Void) {
        moyaProvider.request(.addReview(request: request)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<PostReviewDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func putReview(reviewId: Int ,request: PutReviewRequestModel, completion: @escaping (NetworkResult<PutReviewDTO>) -> Void) {
        moyaProvider.request(.editReview(reviewId: reviewId, request: request)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<PutReviewDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func delReview(reviewId: Int, completion: @escaping (NetworkResult<DelReviewDTO>) -> Void) {
        moyaProvider.request(.delReview(reviewId: reviewId)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<DelReviewDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}

