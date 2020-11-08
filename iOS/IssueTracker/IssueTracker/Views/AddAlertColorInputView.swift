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
    private var randomColorGenerator: UIButton = UIButton(type: .system)
    var color: UIColor? {
        didSet {
            textField.text = color?.hexString
            colorPicker.backgroundColor = color
        }
    }
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
    
    override func configure(title: String, placeholder: String, text: String?) {
        super.configure(title: title, placeholder: placeholder, text: text)
        guard let text = text else { return }
        color = UIColor(hex: text)
    }
    override func setUp() {
        super.setUp()
        colorPicker.layer.borderWidth = 0.5
        colorPicker.layer.borderColor = UIColor.label.cgColor
        colorPicker.layer.cornerRadius = 5
        colorPicker.clipsToBounds = false
        randomColorGenerator.layer.cornerRadius = 10
        randomColorGenerator.setTitle("↻", for: .normal)
        randomColorGenerator.tintColor = .label
        randomColorGenerator.backgroundColor = .systemGray2
        randomColorGenerator.tintColor = .label
        randomColorGenerator.addTarget(self, action: #selector(touchedRandomColor), for: .touchUpInside)
        stackView.addArrangedSubview(colorPicker)
        stackView.addArrangedSubview(randomColorGenerator)
        NSLayoutConstraint.activate([
            colorPicker.widthAnchor.constraint(equalToConstant: 50),
            colorPicker.heightAnchor.constraint(equalToConstant: 24),
            randomColorGenerator.widthAnchor.constraint(equalTo: randomColorGenerator.heightAnchor)
        ])
    }
    
    // MARK: - Methods
    
    @objc private func touchedRandomColor() {
        color = UIColor.random
    }
    
    override func validate() {
        super.validate()
        color = nil
    }
}

// MARK: ColorPickerViewController Delegate

extension AddAlertColorInputView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
    }
}
