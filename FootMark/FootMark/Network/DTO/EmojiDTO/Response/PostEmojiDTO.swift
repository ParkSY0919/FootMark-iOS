//
//  PostEmojiDTO.swift
//  FootMark
//
//  Created by 박신영 on 6/9/24.
//

import Foundation

// MARK: - PostEmojiDTO
struct PostEmojiDTO: Codable {
    let statusCode: Int
    let message: String
    let data: PostEmojiDataClass
}

// MARK: - PostEmojiDataClass
struct PostEmojiDataClass: Codable {
    let emojiID: Int
    let createAt, todayEmoji: String

    enum CodingKeys: String, CodingKey {
        case emojiID = "emojiId"
        case createAt, todayEmoji
    }
}
