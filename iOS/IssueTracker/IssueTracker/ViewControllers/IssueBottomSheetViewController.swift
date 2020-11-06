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
    private enum State {
        case partial
        case full
    }
    private var fullViewPosition: CGFloat {
        150
    }
    private var partialViewPosition: CGFloat {
        UIScreen.main.bounds.height - 120
    }
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
            self.moveView(state: .partial)
        })
    }
    
    // MARK: - initialize
    
    private func configure() {
        view.backgroundColor = .systemGray6
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        view.layer.cornerRadius = 10
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
    
    // MARK: - Methods
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? partialViewPosition : fullViewPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
        shadowView.alpha = state == .partial ? 0 : 0.5
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translation(in: view)
        let minY = view.frame.minY
        guard (minY + transition.y >= fullViewPosition) && (minY + transition.y <= partialViewPosition) else { return }
        view.frame = CGRect(x: 0, y: minY + transition.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: view)
        guard minY <= (250 + fullViewPosition) else { return }
        let alpha = 0.5 - (minY - fullViewPosition) / 500.0
        shadowView.alpha = alpha
    }
    
    // MARK: Selectors
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        guard recognizer.state == .ended else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            guard let self = self else { return }
            let state: State = self.view.frame.minY >= UIScreen.main.bounds.height / 2 ? .partial : .full
            self.moveView(state: state)
        }, completion: nil)
    }
    
    @IBAction func touchedUpButton(_ sender: Any) {
        delegate?.moveToUp()
    }
    @IBAction func touchedDownButton(_ sender: Any) {
        delegate?.moveToDown()
    }
}
