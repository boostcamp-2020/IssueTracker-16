//
//  CommentCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/04.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: CommentCollectionViewCell.self)
    
    // MARK: Views
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    
    // MARK: Properties
    
    var moreHandler: ((CommentCollectionViewCell) -> Void)?
    var comment: Comment? {
        didSet {
            writerLabel.text = comment?.writer?.id
            contentLabel.text = comment?.content
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = df.date(from: comment?.createdAt ?? "")!
            timeLabel.text = Date().agoText(from: date)
        }
    }
    
    func configure() {
        emojiButton.layer.cornerRadius = emojiButton.frame.width
        imageView.layer.cornerRadius = 10
    }
    
    @IBAction func touchedMoreButton(_ sender: UIButton) {
        moreHandler?(self)
    }
}
