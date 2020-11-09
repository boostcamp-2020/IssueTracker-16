//
//  GithubLabel.swift
//  IssueTracker
//
//  Created by woong on 2020/11/03.
//

import UIKit

class GithubLabel: PaddingLabel {
    var label: Label? {
        didSet {
            guard let label = label else { return }
            text = label.name
            backgroundColor = UIColor(hex: label.color)
            textColor = backgroundColor?.isDarkColor ?? true ? .white : .black
            setupInsets()
            
        }
    }
    
    func setupInsets(top: CGFloat = 2, leading: CGFloat = 6, trailing: CGFloat = 6, bottom: CGFloat = 2) {
        topInset = top
        leftInset = leading
        rightInset = trailing
        bottomInset = bottom
    }
    
}
