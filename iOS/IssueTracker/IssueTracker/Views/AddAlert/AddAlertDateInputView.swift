//
//  AddAlertDateInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import UIKit

class AddAlertDateInputView: AddAlertInputView {
    override func validate() {
        guard let text = textField.text else { return }
        guard text.isEmpty || text.dateRegEx != nil else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.1022848887)
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = nil
    }
}
