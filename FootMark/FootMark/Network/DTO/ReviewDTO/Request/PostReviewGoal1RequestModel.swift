//
//  PostReviewRequestModel.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation

// MARK: - PostReviewGoal1RequestModel
struct PostReviewGoal1RequestModel: Codable {
    let createAt: String
    let categoryId: Int
    let content: String
}
