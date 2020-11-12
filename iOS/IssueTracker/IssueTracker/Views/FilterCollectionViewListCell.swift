//
//  FilterCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/11.
//

import UIKit

class FilterCollectionViewListCell: UICollectionViewListCell {
    
    var filterItem: FilterViewController.FilterItem?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var backgroundConfig = UIBackgroundConfiguration.listGroupedHeaderFooter().updated(for: state)
        var content = defaultContentConfiguration().updated(for: state)
        if state.isSelected {
            content.textProperties.color = .black
            backgroundConfig.backgroundColor = .clear
            accessories = [.checkmark(options: .init(tintColor: .systemBlue))]
        } else {
            accessories = []
        }
        content.text = filterItem?.title
        contentConfiguration = content
        backgroundConfiguration = backgroundConfig
    }
}
