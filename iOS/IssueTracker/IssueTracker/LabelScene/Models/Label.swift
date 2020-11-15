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
    var description: String?
    var color: String
    
    var jsonData: [String: Any] {
        return [
            "name": name,
            "description": description,
            "color": color.replacingOccurrences(of: "#", with: "")
        ]
    }
    
    /**
    새로 생성을 위한 initializer
     - id: -1
     */
    init(name: String, description: String, color: String) {
        self.id = -1
        self.name = name
        self.description = description
        self.color = color
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

extension Label: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "num"
        case name, description, color
    }
}

extension Label: Inputable {
    
}
