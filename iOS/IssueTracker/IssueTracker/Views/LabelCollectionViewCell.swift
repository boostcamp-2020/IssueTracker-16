//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell, ActionCollectionViewCell {
    
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
    var deleteHandler: ((Int, UICollectionViewCell) -> ())?
    var labelID: Int?
    
    // MARK: - Views
    
    @IBOutlet weak var labelName: GithubLabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
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
    
    func configure(label: Label) {
        self.transform = .identity
        labelName.label = label
        labelDescription.text = label.description
        self.labelID = label.id
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
    
    @IBAction func touchedDeleteButton(_ sender: Any) {
        guard let labelID = labelID,
              let deleteHandler = deleteHandler else { return }
        deleteHandler(labelID, self)
    }
    
}
