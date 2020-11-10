//
//  MilestoneCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class MilestoneCollectionViewCell: UICollectionViewCell, ActionCollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    var currentState: ActionState = .none {
        didSet {
            switch currentState {
            case .none:
                changeNone()
            case .swiped:
                changeSwiped()
            default:
                break
            }
        }
    }
    var delegate: SwipeControllerDelegate?
    
    // MARK: - Views
    
    @IBOutlet weak var milestoneName: PaddingLabel!
    @IBOutlet weak var milestoneDescription: UILabel!
    @IBOutlet weak var milestoneDueDate: UILabel!
    @IBOutlet weak var milestonePercent: UILabel!
    @IBOutlet weak var milestoneOpenIssues: UILabel!
    @IBOutlet weak var milestoneClosedIssues: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSwipeGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSwipeGestures()
    }
    
    private func addSwipeGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        addGestureRecognizer(swipeLeftGesture)
        addGestureRecognizer(swipeRightGesture)
    }
    
    func configure(milestone: Milestone) {
        self.transform = .identity
        milestoneName.text = milestone.title
        milestoneDescription.text = milestone.description
        milestoneOpenIssues.text = "\(milestone.openedIssues ?? 0) open"
        milestoneClosedIssues.text = "\(milestone.closedIssues ?? 0) closed"
        milestonePercent.text = "\(Int(round(milestone.percentage * 100)))%"
        if let dueDate = milestone.dueDate, !dueDate.isEmpty {
            let formattedDate: String = {
                let arr = dueDate.components(separatedBy: "-")
                return "\(arr[0])년 \(arr[1])월 \(arr[2])일"
            }()
            milestoneDueDate.text = formattedDate
        } else {
            milestoneDueDate.text = ""
        }
    }
    
    // MARK: - Methods
    
    func changeNone() {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
                self?.containerView.transform = .identity
            }
        }
    }
    func changeSwiped() {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent], animations: {
                self?.containerView.transform = CGAffineTransform(translationX: (self?.deleteButton.frame.width ?? 0) * -1, y: 0)
            })
        }
    }
    func changeEditMode() {}
    
    @objc func swipeHandler(sender: UISwipeGestureRecognizer) {
        guard currentState != .edit,
              sender.direction == .left || sender.direction == .right else { return }
        if (sender.direction == .left && currentState == .none)
            || (sender.direction == .right && currentState == .swiped) {
            delegate?.swipeController(self)
        }
    }
    
}
