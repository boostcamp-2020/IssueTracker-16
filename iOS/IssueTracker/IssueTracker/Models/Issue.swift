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
    var milestone: Milestone
    var assignees: [Assignee]
    var comment: Comment?
    var comments: [Comment]?
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

struct Comment: Codable {
    var num: Int?
    var content: String
    var createdAt: String?
    var writer: WriterResponse?
}

struct WriterResponse: Codable {
    let num: Int
    let id: String
}

/* {
 "num":1,
 "name":"feature",
 "color":"c4dafa",
 "issues_labels":{"issue_num":3,"label_num":1}
 }
 */
//struct LabelResponse: Codable {
//    var num: Int
//    var name: String
//    var color: String
//    // var issues_labels: IssuesLabels
//}

struct IssuesLabels: Codable {
    let issueNum, labelNum: Int

    enum CodingKeys: String, CodingKey {
        case issueNum = "issue_num"
        case labelNum = "label_num"
    }
}

// {"num":2,"title":"week 2"}
//struct MilestoneResponse: Codable {
//    var num: Int
//    var title: String
//    var openedIssues: Int?
//    var closedIssues: Int?
//}

// "author":{"num":1,"id":"user01"}
struct AuthorResponse: Codable {
    var num: Int
    var id: String
}

extension Issue: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case title, author, createdAt, isClosed, labels, milestone, assignees, comment, comments
    }
}
