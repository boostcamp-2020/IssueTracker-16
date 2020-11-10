//
//  CommentViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/11/09.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak private var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    private var keyboardFrame: CGRect = .zero
    
    var sendHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChanged(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        scrollViewBottomConstraint.constant = keyboardValue.cgRectValue.height
    }
    
    @IBAction func touchedCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchedSendButton(_ sender: UIBarButtonItem) {
        sendHandler?(textView.text)
    }
}
