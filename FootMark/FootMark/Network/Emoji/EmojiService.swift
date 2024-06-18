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
    func putEmoji(createAt: String ,request: PutEmojiRequestModel, completion: @escaping (NetworkResult<PutEmojiDTO>) -> Void)
}

final class EmojiService: BaseService, EmojiServiceProtocol {
    let moyaProvider: MoyaProvider<EmojiTargetType>
    
    override init() {
        self.moyaProvider = MoyaProvider<EmojiTargetType>(
            requestClosure: KeychainManager.shared.createRequestClosure(),
            plugins: [MoyaLoggingPlugin()]
        )
        super.init()
    }
    
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
    
    func putEmoji(createAt: String ,request: PutEmojiRequestModel, completion: @escaping (NetworkResult<PutEmojiDTO>) -> Void) {
        moyaProvider.request(.editEmoji(createAt: createAt, request: request)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<PutEmojiDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
