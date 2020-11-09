//
//  AddAlertColorInputView.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/29.
//

import UIKit

class AddAlertColorInputView: AddAlertInputView {
    
    // MARK: - Properties
    
    var color: UIColor? {
        didSet {
            textField.text = color?.hexString
            colorPicker.backgroundColor = color
            picker.selectedColor = color ?? .random
        }
    }
    var colorPicker: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = false
        return button
    }()
    private var randomColorGenerator: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("↻", for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemGray2
        button.tintColor = .label
        button.addTarget(self, action: #selector(touchedRandomColor), for: .touchUpInside)
        return button
    }()
    lazy var picker: UIColorPickerViewController = {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.modalTransitionStyle = .coverVertical
        picker.modalPresentationStyle = .popover
        if let color = color {
            picker.selectedColor = color
        } else {
            picker.selectedColor = UIColor.random
        }
        picker.delegate = self
        return picker
    }()
    
    // MARK: - initialize
    
    override func configure(title: String, placeholder: String?, text: String?) {
        color = UIColor(hex: text ?? "")
        super.configure(title: title, placeholder: placeholder, text: text)
    }
    override func setUp() {
        super.setUp()
        stackView.addArrangedSubview(colorPicker)
        stackView.addArrangedSubview(randomColorGenerator)
        NSLayoutConstraint.activate([
            colorPicker.widthAnchor.constraint(equalToConstant: 50),
            colorPicker.heightAnchor.constraint(equalToConstant: 24),
            randomColorGenerator.widthAnchor.constraint(equalTo: randomColorGenerator.heightAnchor)
        ])
        validate()
    }
    
    // MARK: - Methods
    
    @objc private func touchedRandomColor() {
        color = UIColor.random
    }
    
    override func clear() {
        var whiteOrBlack: CGFloat = 0
        UIColor.systemBackground.getWhite(&whiteOrBlack, alpha: nil)
        color = UIColor(red: whiteOrBlack, green: whiteOrBlack, blue: whiteOrBlack, alpha: 1)
    }
    override func validate() {
        guard let text = textField.text,
              let color = UIColor(hex: text) else {
            self.layer.borderColor = UIColor.systemRed.cgColor
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.1022848887)
            return
        }
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = nil
        self.color = color
    }
}

// MARK: ColorPickerViewController Delegate

extension AddAlertColorInputView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
    }
}
