//
//  AddAlertInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class AddAlertInputView: UIView {
    
    // MARK: - Properties
    
    var titleLabel: UILabel = UILabel()
    var textField: UITextField = UITextField()
    var stackView: UIStackView = UIStackView()
    
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
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(textField)
        self.addSubview(titleLabel)
        self.addSubview(stackView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 40),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        addBottomLine()
    }
    
    // MARK: - 밑 줄 그리기
    
    private func addBottomLine() {
        let lineWidth: CGFloat = 1
        let lineView = UIView()
        lineView.backgroundColor = .systemGray5
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor).isActive = true
    }
    
    func configure(title: String, placeholder: String, text: String?) {
        titleLabel.text = title
        textField.placeholder = placeholder
        if let text = text {
            textField.text = text
        }
    }
    
}
