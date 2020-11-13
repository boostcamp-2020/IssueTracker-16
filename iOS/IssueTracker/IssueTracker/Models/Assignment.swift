//
//  Assignment.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/12.
//

import Foundation

struct AssigneeAssignment: Codable {
    let issueNum: Int
    let userNum: Int
    
    var jsonData: [String: Any] {
        return [
            "issueNum": issueNum,
            "userNum": userNum
        ]
    }
}
struct LabelAssignment: Codable {
    let issueNum: Int
    let labelNum: Int
    
    var jsonData: [String: Any] {
        return [
            "issueNum": issueNum,
            "labelNum": labelNum
        ]
    }
}
struct MilestoneAssignment: Codable {
    let milestoneNum: Int?
    
    var jsonData: [String: Any] {
        return [
            "milestoneNum": milestoneNum ?? NSNull()
        ]
    }
}
