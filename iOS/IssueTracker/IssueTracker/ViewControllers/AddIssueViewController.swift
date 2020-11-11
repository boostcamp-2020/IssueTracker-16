//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/05.
//

import UIKit
import MarkdownView

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
    @IBOutlet weak private var mdSegmentControl: UISegmentedControl!
    private var mdPreview: MarkdownView?
    private var isPreviewMode = false {
        didSet {
            isPreviewMode ? openPreview() : closePreview()
        }
    }
    
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
    
    private func generateMDView(on superView: UIView) -> MarkdownView {
        let mdView = MarkdownView()
        mdView.backgroundColor = superView.backgroundColor
        mdView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mdView)
        
        mdView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        mdView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        mdView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        mdView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        
        return mdView
    }
    
    private func openPreview() {
        mdPreview = generateMDView(on: commentTextView)
        mdPreview?.load(markdown: commentTextView.text)
    }
    
    private func closePreview() {
        self.mdPreview?.removeFromSuperview()
        mdPreview = nil
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
