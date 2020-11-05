//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    @IBOutlet weak var labelName: GithubLabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    // MARK: - Methods
    
    func configure(label: Label) {
        labelName.label = label
        labelDescription.text = label.description
    }
}
