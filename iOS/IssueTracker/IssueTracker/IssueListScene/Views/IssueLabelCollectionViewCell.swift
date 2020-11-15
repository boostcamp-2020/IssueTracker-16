//
//  IssueLabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/12.
//

import UIKit

class IssueLabelCollectionViewCell: UICollectionViewCell {
    static let identifier = "IssueLabelCollectionViewCell"
    
    @IBOutlet weak private var githubLabel: GithubLabel!
    
    var label: Label? {
        didSet {
            githubLabel.label = label            
        }
    }
}
