//
//  PutReviewDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation

// MARK: - WePutReviewDTOlcome
struct PutReviewDTO: Codable {
    let statusCode: Int
    let message: String
    var data: PutReviewDataClass
}

// MARK: - PutReviewDataClass
struct PutReviewDataClass: Codable {
    let reviewID, memberID, categoryID: Int
    var content: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case memberID = "memberId"
        case categoryID = "categoryId"
        case content
    }
}
