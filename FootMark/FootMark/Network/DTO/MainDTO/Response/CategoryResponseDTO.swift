//
//  CategoryResponseDTO.swift
//  FootMark
//
//  Created by 박신영 on 6/19/24.
//

import Foundation

// MARK: - Temperatures
struct PostCategoryResponseDTO: Codable {
    let statusCode: Int
    let message: String
    let data: PostCategoryDataClass
}

// MARK: - PostCategoryDataClass
struct PostCategoryDataClass: Codable {
    let categoryID: Int
    let categoryName, color: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, color
    }
}

