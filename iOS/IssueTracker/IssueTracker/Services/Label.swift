//
//  Label.swift
//  IssueTracker
//
//  Created by woong on 2020/10/28.
//

import Foundation

struct Label {
    var id: Int
    var name: String
    var description: String
    var color: String
}

extension Label: Hashable {
    static func ==(lhs: Label, rhs: Label) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Label: Inputable {
    
}

extension Label: Codable {
    
}
