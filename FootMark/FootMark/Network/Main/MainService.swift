//
//  MainService.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//


import Foundation
import Moya
import KeychainSwift

protocol MainServiceProtocol {
    func getTodos(createAt: String , completion: @escaping (NetworkResult<TodosResponseDTO>) -> Void)
}

final class MainService: BaseService, MainServiceProtocol {
    let moyaProvider: MoyaProvider<MainTargetType>
    
    override init() {
        self.moyaProvider = MoyaProvider<MainTargetType>(
            requestClosure: KeychainManager.shared.mainTargetRequestClosure(),
            plugins: [MoyaLoggingPlugin()]
        )
    }
    
    func getTodos(createAt: String , completion: @escaping (NetworkResult<TodosResponseDTO>) -> Void) {
        moyaProvider.request(.getTodo(createAt: createAt)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data

                let networkResult: NetworkResult<TodosResponseDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
