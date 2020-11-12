//
//  Milestone.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import Foundation

struct MilestoneAPI: Codable {
    var open: Int
    var closed: Int
    var milestones: [Milestone]
}

struct Milestone {
    var id: Int
    var title: String
    var dueDate: String?
    var description: String?
    var isClosed: Bool?
    var openedIssues: Int?
    var closedIssues: Int?
    
    var jsonData: [String: Any] {
        return [
            "title": title,
            "dueDate": dueDate == "" ? NSNull() : dueDate,
            "description": description
        ]
    }
    
    /**
    새로 생성을 위한 initializer
     - id: -1
     - open된 상태, 연결된 이슈 0개인 상태
     */
    init(title: String, dueDate: String, description: String) {
        self.id = -1
        self.title = title
        self.dueDate = dueDate
        self.description = description
        self.isClosed = false
        self.openedIssues = 0
        self.closedIssues = 0
    }
    
    var percentage: Double {
        guard let closed = closedIssues, closed != 0 else { return 0 }
        let opened = openedIssues ?? 0
        return Double(closed) / Double(opened + closed)
    }
}

extension Milestone: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case title, dueDate, description, isClosed, openedIssues, closedIssues
    }
}

extension Milestone: Inputable {
    
}
