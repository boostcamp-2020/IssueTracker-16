//
//  CommentCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/04.
//

import UIKit
import MarkdownView

class CommentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: CommentCollectionViewCell.self)
    
    // MARK: Views
    
    @IBOutlet weak var textViewBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    private var mdView: MarkdownView?
    
    // MARK: Properties
    
    var moreHandler: ((CommentCollectionViewCell) -> Void)?
    var comment: Comment? {
        didSet {
            
            contentLabel.text = comment?.content
            mdView = generateMDView()
            writerLabel.text = comment?.writer?.id
            mdView?.load(markdown: comment?.content)
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = df.date(from: comment?.createdAt ?? "")!
            timeLabel.text = Date().agoText(from: date)
        }
    }
    
    private func generateMDView() -> MarkdownView {
        let mdView = MarkdownView()
        mdView.backgroundColor = .systemBackground
        mdView.frame = contentLabel.frame
        mdView.frame.origin.x = 0
        mdView.frame.size.width = moreButton.frame.maxX - imageView.frame.minX
        
        addSubview(mdView)
        return mdView
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction private func touchedMoreButton(_ sender: UIButton) {
        moreHandler?(self)
    }
}
