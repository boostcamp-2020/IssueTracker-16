//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/02.
//

import UIKit

class IssueListCollectionViewCell: ActionCollectionViewCell {
    static let identfier = String(describing: IssueListCollectionViewCell.self)
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var editingView: UIView!
    @IBOutlet private weak var editingButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override var isSelected: Bool {
        didSet {
            editingButton.isSelected = isSelected
        }
    }
    var currentState: ActionState = .none
    
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
        print(sender.direction)
        if sender.direction == .left && currentState == .none {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
                self.contentView.transform = CGAffineTransform(translationX: self.deleteButton.frame.width * -1, y: 0)
            }
            currentState = .swiped
        } else if sender.direction == .right && currentState == .swiped {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent], animations: {
                self.contentView.transform = .identity
            }, completion: { [weak self] _ in
                self?.currentState = .none
            })
        }
    }
    
    private func changeEditMode() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            
            self.contentView.transform = CGAffineTransform(translationX: self.editingView.frame.width, y: 0)
        }
    }
    
    private func changeNone() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.contentView.transform = .identity
        }
    }
    
    private func changeSwipeLeft() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowAnimatedContent]) {
            self.contentView.transform = CGAffineTransform(translationX: -50, y: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch currentState {
        case .none:
            changeNone()
        case .edit:
            changeEditMode()
        case .swiped:
//            changeSwipeLeft()
            //
            break
        }
    }
    @IBAction private func touchedDeleteButton(_ sender: Any) {
        debugPrint("delete")
    }
}
