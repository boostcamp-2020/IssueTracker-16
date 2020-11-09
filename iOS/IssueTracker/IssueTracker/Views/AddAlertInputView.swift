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
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    var textField: UITextField = UITextField()
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    var beginEditingHandler: ((UITextField) -> Void)?
    var returnHandler: ((UITextField) -> Void)?
    var isValid: Bool {
        return self.layer.borderColor == UIColor.clear.cgColor ? true : false
    }
    
    // MARK: - Initialize
    
    required init(title: String, placeholder: String?, text: String?) {
        super.init(frame: .zero)
        configure(title: title, placeholder: placeholder, text: text)
        setUp()
    }
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
        setUp()
    }
    
    func configure(title: String, placeholder: String?, text: String?) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.text = text
    }
    
    internal func setUp() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 5
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
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
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 40),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        addBottomLine()
        validate()
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
    
    // MARK: - Methods
    
    internal func clear() {
        textField.text = ""
        validate()
    }
    
    internal func validate() {
        guard let title = titleLabel.text, title == "제목" else { return }
        guard let text = textField.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.1022848887)
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = nil
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
        validate()
    }
}
