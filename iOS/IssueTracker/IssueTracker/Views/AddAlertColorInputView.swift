//
//  AddAlertColorInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import UIKit

class AddAlertColorInputView: AddAlertInputView {
    
    // MARK: - Properties
    
    var colorPicker: UIButton = UIButton()
    
    // MARK: - initialize
    
    override func configure(title: String, placeholder: String, text: String?) {
        super.configure(title: title, placeholder: placeholder, text: text)
        colorPicker.layer.borderWidth = 1
        colorPicker.layer.borderColor = UIColor.label.cgColor
        colorPicker.layer.cornerRadius = 5
        colorPicker.clipsToBounds = true
        if let text = text {
            colorPicker.backgroundColor = UIColor(hex: text)
        }
        stackView.addArrangedSubview(colorPicker)
        colorPicker.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
