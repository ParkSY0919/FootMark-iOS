//
//  FirstLoginDTO.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//

import Foundation

// MARK: - FirstLoginDTO
struct FirstLoginDTO: Codable {
    let statusCode: Int
    let message: String
    let data: FirstLoginDataClass
}

// MARK: - FirstLoginDataClass
struct FirstLoginDataClass: Codable {
    let categoryIDS: [Int]
    let isFirstLogin: Bool

    enum CodingKeys: String, CodingKey {
        case categoryIDS = "categoryIds"
        case isFirstLogin
    }
}

