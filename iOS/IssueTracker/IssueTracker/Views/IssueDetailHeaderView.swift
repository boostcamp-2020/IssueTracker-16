//
//  IssueDetailHeaderView.swift
//  IssueTracker
//
//  Created by woong on 2020/11/05.
//

import UIKit

class IssueDetailHeaderView: UICollectionReusableView {
    static let identifier = "\(IssueDetailHeaderView.self)"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var issue: Issue? {
        didSet {
            titleLabel.text = issue?.title
            numberLabel.text = "#\(issue?.id ?? 0)"
            authorLabel.text = issue?.author.id
        }
    }
}
