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
    
    var jsonData: [String: Any] {
        return [
            "name": name,
            "description": description,
            "color": color.replacingOccurrences(of: "#", with: "")
        ]
    }
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
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case name, description, color
    }
}
