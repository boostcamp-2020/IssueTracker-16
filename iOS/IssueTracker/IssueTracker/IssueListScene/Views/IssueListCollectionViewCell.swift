//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/02.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell, ActionCollectionViewCell {
    
    static let identfier = String(describing: IssueListCollectionViewCell.self)
    
    // MARK: Views
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var milestoneLabel: PaddingLabel!
    @IBOutlet weak var editingButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var editingView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelStackView: LabelStackView!
    
    var issue: Issue? {
        didSet {
            nameLabel.text = issue?.title
            descriptionLabel.text = ""
            milestoneLabel.text = issue?.milestone?.title
            milestoneLabel.isHidden = issue?.milestone == nil
            descriptionLabel.text = issue?.comment?.content
            
            configure(labels: issue?.labels ?? [])
        }
    }
    
    private func configure(labels: [Label]) {
        labelStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        labelStackView.frame.size.width = frame.width - 20
        labelStackView.configure(labels: labels)
    }
    
    override var isSelected: Bool {
        didSet {
            editingButton.isSelected = isSelected
        }
    }
    
    var currentState: ActionState = .none
    var delegate: SwipeControllerDelegate?
    var deleteHandler: ((Int, UICollectionViewCell) -> ())?
    
    func addSwipeGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        addGestureRecognizer(swipeLeftGesture)
        addGestureRecognizer(swipeRightGesture)
    }
    
    @objc private func swipeHandler(sender: UISwipeGestureRecognizer) {
        guard currentState != .edit,
              sender.direction == .left || sender.direction == .right else { return }
        if sender.direction == .left && currentState == .none {
            delegate?.swipeController(self)
        } else if sender.direction == .right && currentState == .swiped {
            delegate?.swipeController(self)
        }
    }
    
    func changeEditMode() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.containerView.transform = CGAffineTransform(translationX: self.editingView.frame.width, y: 0)
        }
    }
    
    func changeNone() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.containerView.transform = .identity
        }
    }
    
    func changeSwiped() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent], animations: {
            self.containerView.transform = CGAffineTransform(translationX: self.deleteButton.frame.width * -1, y: 0)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch currentState {
        case .none:
            changeNone()
        case .edit:
            changeEditMode()
        case .swiped:
            changeSwiped()
        }
    }
    
    @IBAction private func touchedDeleteButton(_ sender: Any) {
        guard let issueID = issue?.id,
              let deleteHandler = deleteHandler else { return }
        deleteHandler(issueID, self)
    }
}
