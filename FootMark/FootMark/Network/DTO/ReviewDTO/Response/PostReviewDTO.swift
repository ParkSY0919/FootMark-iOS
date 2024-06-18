//
//  PostReviewDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation

// MARK: - PostReviewDTO
struct PostReviewDTO: Codable {
    let statusCode: Int
    let message: String
    var data: PostReviewDataClass
}

// MARK: - PostReviewDTOClass
struct PostReviewDataClass: Codable {
    let reviewID, memberID, categoryID: Int
    var content: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case memberID = "memberId"
        case categoryID = "categoryId"
        case content
    }
}
