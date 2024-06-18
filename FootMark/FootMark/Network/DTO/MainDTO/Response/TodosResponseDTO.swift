//
//  TodosResponseDTO.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//

import Foundation

// MARK: - TodosResponseDTO
struct TodosResponseDTO: Codable {
    let statusCode: Int
    let message: String
    let data: TodosResponseDataClass
}

// MARK: - DataClass
struct TodosResponseDataClass: Codable {
    let todoDateResDtos: [TodosResponseDataResDto]
    let completionRate: Int
    let diaryExists: Bool
    let todayEmoji: String?

    enum CodingKeys: String, CodingKey {
        case todoDateResDtos, completionRate, diaryExists, todayEmoji
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        todoDateResDtos = try container.decode([TodosResponseDataResDto].self, forKey: .todoDateResDtos)
        completionRate = try container.decode(Int.self, forKey: .completionRate)
        diaryExists = try container.decode(Bool.self, forKey: .diaryExists)
        todayEmoji = try? container.decode(String.self, forKey: .todayEmoji) ?? nil
    }
}

// MARK: - TodoDateResDto
struct TodosResponseDataResDto: Codable {
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

