//
//  PutEmojiDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/10/24.
//

import Foundation

// MARK: - PutEmojiDTO
struct PutEmojiDTO: Codable {
    let statusCode: Int
    let message: String
    let data: PutEmojiDataClass
}

// MARK: - PutEmojiDataClass
struct PutEmojiDataClass: Codable {
    let emojiID: Int
    let createAt, todayEmoji: String
    
    enum CodingKeys: String, CodingKey {
        case emojiID = "emojiId"
        case createAt, todayEmoji
    }
}
