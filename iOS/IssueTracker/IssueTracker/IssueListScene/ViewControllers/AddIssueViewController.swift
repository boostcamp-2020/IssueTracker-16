//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/05.
//

import UIKit
import SwiftyMarkdown

protocol AddIssueViewControllerDelegate {
    func addIssueViewControllerDoned(_ addIssueViewController: AddIssueViewController)
}

class AddIssueViewController: UIViewController {
    
    // MARK: - Constants
    
    static let fromSegueIdentifier: String = "present\(String(describing: AddIssueViewController.self))"
    
    // MARK: - Properties
    
    var delegate: AddIssueViewControllerDelegate?
    var issue: Issue?
    
    // MARK: - Views
    
    @IBOutlet weak private(set) var issueID: UILabel!
    @IBOutlet weak private(set) var issueTitle: UITextField!
    @IBOutlet weak private(set) var commentTextView: UITextView!
    @IBOutlet weak private(set) var mdSegmentControl: UISegmentedControl!
    @IBOutlet weak var textViewBottmConstraint: NSLayoutConstraint!

    private(set) var originText: String?
    private var isPreviewMode = false {
        didSet {
            isPreviewMode ? openPreview() : closePreview()
        }
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        configure()
    }
    
    // MARK: - initialize
    
    private func configure() {
        guard let issue = issue else {
            issueID.text = "새 이슈"
            return
        }
        
        self.issueID.text = "#\(issue.id)"
        self.issueTitle.text = issue.title
        self.commentTextView.text = issue.comments?.first?.content
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChanged(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        textViewBottmConstraint.constant = keyboardValue.cgRectValue.height
    }
    
    // MARK: - Methods
    
    private func openPreview() {
        originText = commentTextView.text
        let md = SwiftyMarkdown(string: originText ?? "")
        commentTextView.attributedText = md.attributedString()
    }
    
    private func closePreview() {
        commentTextView.typingAttributes.removeAll()
        commentTextView.text = originText
    }
    
    // MARK: IBActions
    
    @IBAction private func touchedDone(_ sender: UIButton) {
        delegate?.addIssueViewControllerDoned(self)
    }
    
    @IBAction private func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func mdSegmentControlChanged(_ sender: UISegmentedControl) {
        isPreviewMode = sender.selectedSegmentIndex == 1
    }
}
