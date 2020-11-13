//
//  User.swift
//  IssueTracker
//
//  Created by woong on 2020/11/10.
//

import Foundation

struct User: Codable {
    let num: Int
    let id: String
    let name: String?
    let imageUrl: String?
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(num)
    }
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.num == rhs.num
    }
}
