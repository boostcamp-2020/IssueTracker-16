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
    var description: String?
    var openedIssues: Int?
    var closedIssues: Int?
    var jsonData: [String: Any] {
        return [
            "title": title,
            "dueDate": dueDate,
            "description": description
        ]
    }
    
    var percentage: Double {
        guard let closed = closedIssues else { return 0 }
        let opened = openedIssues ?? 0
        return Double(closed) / Double(opened + closed)
    }
}

extension Milestone: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case title, dueDate, description, openedIssues, closedIssues
    }
}

extension Milestone: Inputable {
    
}
