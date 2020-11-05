//
//  Milestone.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import Foundation

struct Milestone {
    var id: Int
    var title: String
    var dueDate: String?
    var description: String
    var openedIssues: Int
    var closedIssues: Int
}

extension Milestone: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case title, dueDate, description, openedIssues, closedIssues
    }
}
