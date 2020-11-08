//
//  APIResponse.swift
//  IssueTracker
//
//  Created by woong on 2020/11/08.
//

import Foundation

struct APIResponse: Codable {
    var success: Bool
    var message: String?
}
