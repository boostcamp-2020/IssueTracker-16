//
//  Comment.swift
//  IssueTracker
//
//  Created by woong on 2020/11/10.
//

import Foundation

struct Comment: Codable {
    var num: Int?
    var content: String
    var createdAt: String?
    var writer: User?
    
//    var jsonData: [String: Any] {
//        return [
//            "title": 
//        ]
//    }
}
