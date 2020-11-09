//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/05.
//

import UIKit

class AddIssueViewController: UIViewController {
    
    // MARK: - Constants
    static let fromSegueIdentifier: String = "present\(String(describing: AddIssueViewController.self))"
    
    // MARK: - Properties
    
    var issue: Issue?
    
    // MARK: - Views
    
    @IBOutlet weak var issueID: UILabel!
    @IBOutlet weak var issueTitle: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - initialize
    
    func configure() {
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
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
