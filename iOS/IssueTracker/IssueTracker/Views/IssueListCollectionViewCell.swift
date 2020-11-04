//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/02.
//

import UIKit

class IssueListCollectionViewCell: ActionCollectionViewCell {
    static let identfier = String(describing: IssueListCollectionViewCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var labelsBackgroundView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        // top + spacing + bottom
        let padding: CGFloat = 10 + 6 + 10
        
        
        let contentsSize = CGSize(width: targetSize.width, height: nameLabel.frame.height + descriptionLabel.frame.height + padding)
        
        let labelsSize = CGSize(width: targetSize.width, height: labelsBackgroundView.frame.height + padding)
        
        // FIXME: 둘 중 큰 걸 셀 높이로 잡도록 하고 있는데 더 스마트한 방법이 없을지...
        return (contentsSize.height > labelsSize.height) ? contentsSize : labelsSize
    }
}
