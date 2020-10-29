//
//  MilestoneCollectionViewCell.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class MilestoneCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    @IBOutlet weak var milestoneName: UIButton!
    @IBOutlet weak var milestoneDescription: UILabel!
    @IBOutlet weak var milestoneDueDate: UILabel!
    @IBOutlet weak var milestonePercent: UILabel!
    @IBOutlet weak var milestoneOpenIssues: UILabel!
    @IBOutlet weak var milestoneClosedIssues: UILabel!
    
    // MARK: - Methods
    
    func configure(name: String, description: String, dueDate: String, openIssues: Int, closedIssues: Int) {
        milestoneName.setTitle(name, for: .normal)
        milestoneDescription.text = description
        var formattedDate: String = {
            let arr = dueDate.components(separatedBy: "-")
            return "\(arr[0])년 \(arr[1])월 \(arr[2])일"
        }()
        milestoneDueDate.text = formattedDate
        milestoneOpenIssues.text = "\(openIssues) open"
        milestoneClosedIssues.text = "\(closedIssues) closed"
        let percent = closedIssues != 0 ? Int(round(Float(openIssues) / Float(openIssues + closedIssues) * 100.0)) : 0
        milestonePercent.text = "\(percent)%"
    }
}
