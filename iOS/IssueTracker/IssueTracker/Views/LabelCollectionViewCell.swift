//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static var identifier: String {
        String(describing: self)
    }
    @IBOutlet weak var labelName: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    
}
