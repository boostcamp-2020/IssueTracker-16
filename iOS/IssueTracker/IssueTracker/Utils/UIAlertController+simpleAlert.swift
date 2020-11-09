//
//  UIAlertController+simpleAlert.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/09.
//

import UIKit.UIAlertController

extension UIAlertController {
    static func showSimpleAlert(title: String, handler: (UIAlertController) -> (Void)) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel, handler : nil)
        alert.addAction(cancel)
        handler(alert)
    }
}
