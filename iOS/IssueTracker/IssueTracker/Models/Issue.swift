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
    var author: AuthorResponse?
    var createdAt: String
    var isClosed: Bool
    var labels: [Label]
    var milestone: Milestone?
    var assignees: [Assignee]
    var comment: Comment?
    var comments: [Comment]?
    
    /**
    새로 생성을 위한 initializer
     - id: -1
     - 나머지는 모두 nil or []
     */
    init(title: String, content: String) {
        self.id = -1
        self.title = title
        self.comment = Comment(content: content)
        self.createdAt = ""
        self.isClosed = false
        self.labels = []
        self.assignees = []
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
        case title, author, createdAt, isClosed, labels, assignees, comment, comments
    }
}

struct Assignee: Codable {
    let num: Int
    let id: String
    // let assignments: Assignments
}

struct Assignments: Codable {
    let userNum, issueNum: Int

    enum CodingKeys: String, CodingKey {
        case userNum = "user_num"
        case issueNum = "issue_num"
    }
}

struct AuthorResponse: Codable {
    var num: Int
    var id: String
}

