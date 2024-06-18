//
//  DelReviewDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/18/24.
//

import Foundation

// MARK: - Welcome
struct DelReviewDTO: Codable {
    let statusCode: Int
    let message: String
    let data: Data?
}
