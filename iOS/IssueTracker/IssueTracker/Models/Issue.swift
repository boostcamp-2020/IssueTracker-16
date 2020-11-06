//
//  Issue.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import Foundation

struct Issue {
    var id: Int
    var title: String
    var author: AuthorResponse
    var createdAt: String
    var isClosed: Bool
    var labels: [Label]
    var milestone: MilestoneResponse
    var assignees: [Int]
}
// {"num":2,"title":"week 2"}
struct MilestoneResponse: Codable {
    var num: Int
    var title: String
}

// "author":{"num":1,"id":"user01"}
struct AuthorResponse: Codable {
    var num: Int
    var id: String
}

extension Issue: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case title, author, createdAt, isClosed, labels, milestone, assignees
    }
}
