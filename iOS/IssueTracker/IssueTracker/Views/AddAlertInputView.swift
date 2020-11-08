//
//  AddAlertInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class AddAlertInputView: UIView {
    
    // MARK: - Properties
    
    let lineView = UIView()
    var contentView = UIView()
    var titleLabel: UILabel = UILabel()
    var textField: UITextField = UITextField()
    var stackView: UIStackView = UIStackView()
    var beginEditingHandler: ((UITextField) -> Void)?
    var returnHandler: ((UITextField) -> Void)?
    var isValid: Bool {
        return self.layer.borderColor == UIColor.clear.cgColor ? true : false
    }
    
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
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(textField)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(900), for: .vertical)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            // titleLabel.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 40),
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            // stackView.heightAnchor.constraint(equalTo: self.titleLabel.heightAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        addBottomLine()
    }
    
    // MARK: - 밑 줄 그리기
    
    private func addBottomLine() {
        let lineWidth: CGFloat = 1
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
        guard let text = text,
              text.trimmingCharacters(in: .whitespaces) != "" else {
            if title == "제목" {
                self.layer.borderColor = UIColor.systemRed.cgColor
            }
            return
        }
        textField.text = text
    }
    
}

// MARK: TextField Delegate

extension AddAlertInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditingHandler?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnHandler?(textField)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let title = titleLabel.text, title == "제목" else { return }
        guard let text = textField.text,
              text.trimmingCharacters(in: .whitespaces) != "" else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            // self.lineView.backgroundColor = .systemRed
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.1022848887)
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = .clear
        // self.lineView.backgroundColor = .clear
    }
}
