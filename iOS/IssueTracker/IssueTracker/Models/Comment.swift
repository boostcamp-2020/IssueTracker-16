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
    var writer: WriterResponse?
    
//    var jsonData: [String: Any] {
//        return [
//            "title": 
//        ]
//    }
}

struct WriterResponse: Codable {
    let num: Int
    let id: String
}
