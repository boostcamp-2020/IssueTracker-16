//
//  CommentCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/04.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: CommentCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var emojiButton: UIButton!
    
    func configure() {
        emojiButton.layer.cornerRadius = emojiButton.frame.width
        imageView.layer.cornerRadius = 10
    }
}
