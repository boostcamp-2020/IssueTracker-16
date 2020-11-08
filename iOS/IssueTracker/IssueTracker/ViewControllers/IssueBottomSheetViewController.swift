//
//  IssueBottomSheetViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/02.
//

import UIKit

class IssueBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    static let identifier: String = String(describing: IssueBottomSheetViewController.self)
    
    var delegate: IssueDetailViewController?
    var author: AuthorResponse? {
        didSet {
            authorLabel.text = author?.id
        }
    }
    var milestone: MilestoneResponse? {
        didSet {
            milestoneLabel.text = milestone?.title
        }
    }
    var label: Label? {
        didSet {
            labelLabel.label = label
        }
    }
    
    // MARK: Views
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var labelLabel: GithubLabel!
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var milestonePercentBar: UIProgressView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var issueCloseButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addTopShortLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 120, width: self.view.frame.width, height: self.view.frame.height)
        })
    }
    
    // MARK: - initialize
    
    private func configure() {
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 5
        shadowView.backgroundColor = .label
        shadowView.alpha = 0
    }
    
    private func addTopShortLine() {
        let lineWidth: CGFloat = 4
        let lineView = UIView()
        lineView.layer.cornerRadius = lineWidth / 2
        lineView.backgroundColor = .systemGray2
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            lineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 50),
            lineView.heightAnchor.constraint(equalToConstant: lineWidth)
        ])
    }
    
    @IBAction func touchedUpButton(_ sender: Any) {
        delegate?.moveToUp()
    }
    @IBAction func touchedDownButton(_ sender: Any) {
        delegate?.moveToDown()
    }
}
