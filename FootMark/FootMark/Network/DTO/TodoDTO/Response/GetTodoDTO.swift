//
//  GetTodoDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/19/24.
//

import Foundation

// MARK: - GetTodoDTO
struct GetTodoDTO: Codable {
    let statusCode: Int
    let message: String
    let data: GetTodoDataClass
}

// MARK: - GetTodoDataClass
struct GetTodoDataClass: Codable {
    let todoDateResDtos: [TodoDateResDto]
    let completionRate: Int
    let diaryExists: Bool
    let todayEmoji: String?
}

// MARK: - TodoDateResDto
struct TodoDateResDto: Codable {
    let categoryID: Int
    let categoryName: String
    let content: [String]
    let isCompleted: [Bool]
    let todoID: [Int]

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, content, isCompleted
        case todoID = "todoId"
    }
}
