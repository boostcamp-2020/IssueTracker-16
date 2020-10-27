//
//  AddAlertInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class AddAlertInputView: UIView {
    
    // MARK: - Properties
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    
    // MARK: - Initialize
    
    required init(title: String, placeholder: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        setUp()
    }
    
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
        setUp()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        self.addSubview(textField)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        addBottomLine()
    }
    
    // MARK: - 밑 줄 그리기
    
    func addBottomLine() {
        let lineWidth: CGFloat = 2
        let lineView = UIView()
        lineView.backgroundColor = .systemGray2
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
