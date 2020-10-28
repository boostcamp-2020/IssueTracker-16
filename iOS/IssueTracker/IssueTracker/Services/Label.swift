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

extension Label: Codable {
    
}
