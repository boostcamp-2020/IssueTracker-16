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
    
    override var isSelected: Bool {
        didSet {
            editingButton.isSelected = isSelected
        }
    }
    var currentState: ActionState = .none
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if currentState == .edit {
            changeEditMode()
        } else {
            changeNone()
        }
    }
}
