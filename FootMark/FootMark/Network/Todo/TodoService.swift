//
//  TodoService.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

import Foundation
import Moya
import KeychainSwift

protocol TodoServiceProtocol {
    func getTodo(createAt: String , completion: @escaping (NetworkResult<GetTodoDTO>) -> Void)
}

final class TodoService: BaseService, TodoServiceProtocol {
    let moyaProvider: MoyaProvider<TodoTargetType>
    
    override init() {
        self.moyaProvider = MoyaProvider<TodoTargetType>(
            requestClosure: KeychainManager.shared.createRequestClosure(),
            plugins: [MoyaLoggingPlugin()]
        )
    }
    
    func getTodo(createAt: String , completion: @escaping (NetworkResult<GetTodoDTO>) -> Void) {
        moyaProvider.request(.getTodo(createAt: createAt)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data

                let networkResult: NetworkResult<GetTodoDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
