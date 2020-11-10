//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/05.
//

import UIKit

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
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Methods
    
    // MARK: IBActions
    
    @IBAction private func touchedDone(_ sender: UIButton) {
        delegate?.addIssueViewControllerDoned(self)
    }
    
    @IBAction private func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
