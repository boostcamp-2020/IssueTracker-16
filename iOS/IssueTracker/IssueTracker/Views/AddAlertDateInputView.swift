//
//  AddAlertDateInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import UIKit

class AddAlertDateInputView: AddAlertInputView {
    override func textFieldDidChangeSelection(_ textField: UITextField) {
        super.textFieldDidChangeSelection(textField)
        guard let title = titleLabel.text, title == "완료날짜" else { return }
        guard let text = textField.text, text != "" else {
            self.layer.borderColor = UIColor.clear.cgColor
            return
        }
        let regex = try? NSRegularExpression(
            pattern: "^(?<year>\\d{4})-(?<month>0[1-9]|1[012])-(?<day>0[1-9]|[12][0-9]|3[0-1])$"
        )
        guard let match = regex?.firstMatch(in: text, range: NSRange(location: 0, length: text.count)),
              let yearRange = Range(match.range(withName: "year"), in: text),
              let monthRange = Range(match.range(withName: "month"), in: text),
              let dayRange = Range(match.range(withName: "day"), in: text) else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        debugPrint("\(String(text[yearRange]))-\(String(text[monthRange]))-\(String(text[dayRange]))")
    }
}
