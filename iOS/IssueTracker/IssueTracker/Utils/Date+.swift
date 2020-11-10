//
//  Date+.swift
//  IssueTracker
//
//  Created by woong on 2020/11/09.
//

import Foundation

extension Date {
    
    func format(_ format: String) -> String {
        let df = DateFormatter()
        df.locale = .init(identifier: "ko-KR")
        df.dateFormat = format
        return df.string(from: self)
    }
    
    func agoText(from fromDate: Date) -> String {
        let interval = self.timeIntervalSince(fromDate)
        let hour: Double = 60 * 60
        let today: Double = 24 * hour

        if interval < hour {
            if let minute = Calendar.current.dateComponents([.minute], from: fromDate, to: self).minute {
                return "\(minute)분 전"
            } else {
                print("🚨 이전 시간 계산을 할 수 없습니다. ")
                return ""
            }
        } else if interval <= today {
            if let hour = Calendar.current.dateComponents([.hour], from: fromDate, to: self).hour {
                return "\(hour)시간 전"
            } else {
                print("🚨 이전 시간 계산을 할 수 없습니다. ")
                return ""
            }
        } else {
            if let day = Calendar.current.dateComponents([.day], from: fromDate, to: self).day {
                guard day != 1 else {
                    return "어제"
                }
                return "\(day)일 전"
            }
            return fromDate.format("yyyy.MM.dd")
        }
    }
}
