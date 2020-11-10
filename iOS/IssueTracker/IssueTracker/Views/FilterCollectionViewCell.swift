//
//  FilterCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/11.
//

import UIKit

class FilterCollectionViewListCell: UICollectionViewListCell {
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        if state.isSelected {
            accessories = [.checkmark()]
        } else {
            accessories = []
        }
    }
}
