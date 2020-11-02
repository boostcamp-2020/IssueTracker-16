//
//  String+dateRegEx.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/30.
//

import Foundation

extension String {
    var dateRegEx: String? {
        guard let regex = try? NSRegularExpression(pattern: "^(?<year>\\d{4})-(?<month>0[1-9]|1[012])-(?<day>0[1-9]|[12][0-9]|3[0-1])$"),
              let _ = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count)) else {
            return nil
        }
        return self
    }
}
