//
//  AddAlertViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/10/27.
//

import UIKit

protocol AddAlertViewControllerDelegate: class {
    func addAlertViewController<InputView>(_ addAlertViewController: AddAlertViewController, didTabAddWithTextFields: [InputView])
    
    func addAlertViewControllerDidCancel(_ addAlertViewController: AddAlertViewController)
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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputViews.forEach { contentStackView.addArrangedSubview($0) }
        setupViews()
    }
    
    private func setupViews() {
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
    
    func addInputView(title: String, placeholder: String, text: String?) {
        var inputView: InputView
        if title == "색상" {
            inputView = ColorInputView()
            guard let inputView = inputView as? ColorInputView else { return }
        } else {
            inputView = InputView()
        }
        
        inputView.configure(title: title, placeholder: placeholder, text: text)
        inputViews.append(inputView)
    }
    
    func addInputView(_ inputView: InputView) {
        
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
        delegate?.addAlertViewController(self, didTabAddWithTextFields: inputViews)
    }
    
    @IBAction private func touchedClearButton(_ sender: UIButton) {
        inputViews.forEach { $0.textField.text = "" }
    }
}
