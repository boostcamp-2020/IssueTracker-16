//
//  Issue.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import Foundation

struct IssueAPI: Codable {
    var open: Int
    var closed: Int
    var issues: [Issue]
}

struct Issue {
    var id: Int
    var title: String
    var author: User?
    var createdAt: String
    var isClosed: Bool
    var isDeleted: Bool?
    var labels: [Label]
    var milestone: Milestone?
    var assignees: [User]
    var comment: Comment?
    var comments: [Comment]?
    
    /**
    새로 생성을 위한 initializer
     - id: -1
     - 나머지는 모두 nil or []
     */
    init(
        id: Int = -1,
        title: String,
        author: User? = nil,
        createdAt: String = "",
        isClosed: Bool = false,
        isDeleted: Bool = false,
        labels: [Label] = [],
        milestone: Milestone? = nil,
        assignees: [User] = [],
        comment: Comment? = nil,
        comments: [Comment]? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.isClosed = isClosed
        self.isDeleted = isDeleted
        self.labels = labels
        self.milestone = milestone
        self.assignees = assignees
        self.comment = comment
        self.comments = comments
    }
    
    var createData: [String: Any] {
        return [
            "title": title,
            "content": comment?.content ?? "",
            "labels": labels.compactMap { $0.id },
            "assignees": assignees.compactMap { $0.num },
            "milestoneNum": milestone ?? NSNull()
        ]
    }
    
    var titleData: [String: Any] {
        return [
            "title": title
        ]
    }
    
    var milestoneData: [String: Any] {
        return [
            "milestoneNum": milestone?.id ?? NSNull()
        ]
    }
    
    var statusData: [String: Any] {
        return [
            "isClosed": isClosed
        ]
    }
}

extension Issue: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case milestone = "Milestone"
        case title, author, createdAt, isClosed, isDeleted, labels, assignees, comment, comments
    }
}
