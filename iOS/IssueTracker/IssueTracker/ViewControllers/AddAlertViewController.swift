//
//  AddAlertViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/10/27.
//

import UIKit

protocol Inputable {
    
}

protocol AddAlertViewControllerDelegate: class {
    func addAlertViewControllerDidCancel(_ addAlertViewController: AddAlertViewController)
    
    func addAlertViewController(_ addAlertViewController: AddAlertViewController, didTabAddWithItem item: Inputable?)
}

class AddAlertViewController: UIViewController {
    
    typealias InputView = AddAlertInputView
    typealias ColorInputView = AddAlertColorInputView
    
    // MARK: - Views
    
    @IBOutlet weak private var contentBackgroundView: UIView!
    @IBOutlet weak private var contentView: BlockResponderView!
    @IBOutlet weak private var contentStackView: UIStackView!
    
    // MARK: - Properties
    
    weak var delegate: AddAlertViewControllerDelegate?
    private(set) var inputViews = [InputView]()
    var item: Inputable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addObservers()
    }
    
    private func setupViews() {
        inputViews.forEach { inputview in
            contentStackView.addArrangedSubview(inputview)
            
            inputview.returnHandler = { [weak self] (textField) in
                if let index = self?.inputViews.firstIndex(where: { $0.textField == textField }),
                   index+1 < self?.inputViews.count ?? 0 {
                    self?.inputViews[index+1].textField.becomeFirstResponder()
                } else {
                    self?.view.endEditing(true)
                }
            }
        }
        contentBackgroundView.layer.shadowColor = UIColor.black.cgColor
        contentBackgroundView.layer.shadowRadius = 10
        contentBackgroundView.layer.shadowOffset = .zero
        contentBackgroundView.layer.shadowOpacity = 0.5
        contentView.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func addInputView(title: String, placeholder: String?, text: String?) {
        var inputView: InputView
        if title == "색상" {
            inputView = {
                let colorInputView = ColorInputView(title: title, placeholder: placeholder, text: text)
                colorInputView.colorPicker.addTarget(self, action: #selector(touchedColorPicker), for: .touchUpInside)
                return colorInputView
            }()
        } else if title == "완료날짜"{
            inputView = AddAlertDateInputView(title: title, placeholder: placeholder, text: text)
        } else {
            inputView = InputView(title: title, placeholder: placeholder, text: text)
        }
        inputViews.append(inputView)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: Selectors
    
    @objc private func keyboardWillChanged(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect =  keyboardFrame.cgRectValue

        if contentBackgroundView.frame.maxY > keyboardRect.origin.y {
            view.frame.origin.y = -(contentBackgroundView.frame.maxY - keyboardRect.origin.y + 20)
        } else {
            view.frame.origin.y = 0
        }
    }
    
    @objc private func touchedColorPicker() {
        for inputView in inputViews {
            guard let colorInputView = inputView as? ColorInputView else { continue }
            self.present(colorInputView.picker, animated: true, completion: nil)
            return
        }
    }
    
    // MARK: Private
    
    // MARK: IBActions
    
    @IBAction private func touchedCancelButton(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.addAlertViewControllerDidCancel(self)
        }
    }
    
    @IBAction private func touchedAddButton(_ sender: UIButton) {
        // TODO:
        delegate?.addAlertViewController(self, didTabAddWithItem: item)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchedClearButton(_ sender: UIButton) {
        inputViews.forEach {
            $0.clear()
        }
    }
}
