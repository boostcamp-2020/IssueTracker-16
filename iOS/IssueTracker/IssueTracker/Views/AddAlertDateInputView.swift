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
        guard let date = text.dateRegEx else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        debugPrint(date)
    }
}
