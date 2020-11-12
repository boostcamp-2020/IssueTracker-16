//
//  CommentCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/04.
//

import UIKit
import SwiftyMarkdown

class CommentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: CommentCollectionViewCell.self)
    
    // MARK: Views

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var writerLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var moreButton: UIButton!
    @IBOutlet weak private var emojiButton: UIButton!
    
    // MARK: Properties
    
    var moreHandler: ((CommentCollectionViewCell) -> Void)?
    var comment: Comment? {
        didSet {
            
            let md = SwiftyMarkdown(string: comment?.content ?? "")
            contentLabel.attributedText = md.attributedString()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = df.date(from: comment?.createdAt ?? "")!
            timeLabel.text = Date().agoText(from: date)
        }
    }
    
    @IBAction private func touchedMoreButton(_ sender: UIButton) {
        moreHandler?(self)
    }
}
