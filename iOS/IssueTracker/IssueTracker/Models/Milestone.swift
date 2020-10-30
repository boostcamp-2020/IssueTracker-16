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
    var dueDate: String
    var description: String
    var openIssues: Int
    var closedIssues: Int
}

extension Milestone: Codable {
    
}
