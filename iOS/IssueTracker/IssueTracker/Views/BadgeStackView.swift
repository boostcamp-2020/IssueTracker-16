//
//  BadgeStackView.swift
//  IssueTracker
//
//  Created by woong on 2020/11/13.
//

import UIKit

class LabelStackView: UIStackView {
    
    var horizontolSpacing: CGFloat = 10
    
    
    /**
     기존의 뷰를 모두 제거하고 새롭게 구성할 때 사용
     */
    func configure(labels: [Label]) {
        var labelWidth: CGFloat = 0
        var horizotalStackView = horizontalStackView()
        
        labels.map({ labelView(for: $0) }).forEach { labelView in
            
            horizotalStackView.addArrangedSubview(labelView)
            labelWidth += labelView.subviews.first?.intrinsicContentSize.width ?? 0 + horizontolSpacing
            
            if labelWidth > self.frame.width {
                horizotalStackView.subviews.last?.removeFromSuperview()
                append(horizontol: horizotalStackView)
                horizotalStackView = horizontalStackView()
                horizotalStackView.addArrangedSubview(labelView)
                labelWidth = 0
            }
        }
        
        if !horizotalStackView.subviews.isEmpty {
            self.addArrangedSubview(horizotalStackView)
        }
    }
    
    private func append(horizontol: UIStackView) {
        let view = UIView()
        view.addSubview(horizotalStackView)
        horizotalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        horizotalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        horizotalStackView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 0).isActive = true
        horizotalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        self.addArrangedSubview(view)
    }
    
    private func horizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }
    
    private func labelView(for label: Label) -> UIView {
        let view = UIView()
        let labelView = labelView()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.label = label
        view.addSubview(labelView)
        labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        labelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        return view
    }
    
    var labels: [UILabel]?
}
