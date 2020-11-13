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
            textAlignment = .center
            guard let label = label else { return }
            text = label.name
            backgroundColor = UIColor(hex: label.color)
            textColor = backgroundColor?.isDarkColor ?? true ? .white : .black
            setupInsets()
            
        }
    }
    
    func setupInsets(top: CGFloat = 4, leading: CGFloat = 8, trailing: CGFloat = 8, bottom: CGFloat = 4) {
        layer.masksToBounds = true
        layer.cornerRadius = intrinsicContentSize.height / 3
        topInset = top
        leftInset = leading
        rightInset = trailing
        bottomInset = bottom
    }
    
}
