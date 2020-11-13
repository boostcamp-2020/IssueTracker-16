//
//  BadgeStackView.swift
//  IssueTracker
//
//  Created by woong on 2020/11/13.
//

import UIKit


/// 반드시 axis를 Vertical로 설정
class LabelStackView: UIStackView {
    
    var horizontalSpacing: CGFloat = 10
    private(set) var labels: [Label]?
    private var labelWidth: CGFloat = 0
    
    /// 기존의 뷰를 모두 제거하고 새롭게 구성할 때 사용
    func configure(labels: [Label]) {
        self.labels = labels
        labelWidth = 0
        
        labels.map({ githubLabel(for: $0) }).forEach { labelView in
            append(labelView: labelView)
        }
    }
    
    /// 기존 상태를 유지하고 label을 추가한다.
    func append(label: Label) {
        let labelView = githubLabel(for: label)
        append(labelView: labelView)
    }
    
    private func append(labelView: UIView?) {
        guard let labelView = labelView else { return }
        
        guard let horizotalStackView = arrangedSubviews.last?.subviews.first as? UIStackView else {
            let newHorizontal = horizontalStackView()
            newHorizontal.addArrangedSubview(labelView)
            labelWidth += labelView.subviews[0].intrinsicContentSize.width + horizontalSpacing
            append(horizontal: newHorizontal)
            return
        }
        
        guard labelWidth + labelView.subviews[0].intrinsicContentSize.width + horizontalSpacing > frame.width else {
            horizotalStackView.addArrangedSubview(labelView)
            labelWidth += labelView.subviews[0].intrinsicContentSize.width + horizontalSpacing
            return
        }
        
        let newHorizontal = horizontalStackView()
        newHorizontal.addArrangedSubview(labelView)
        append(horizontal: newHorizontal)
        labelWidth = labelView.subviews[0].intrinsicContentSize.width + horizontalSpacing
    }
    
    private func append(horizontal horizotalStackView: UIStackView) {
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
    
    private func githubLabel(for label: Label) -> UIView {
        let view = UIView()
        
        let githubLabel = GithubLabel()
        githubLabel.translatesAutoresizingMaskIntoConstraints = false
        githubLabel.label = label
        view.addSubview(githubLabel)
        githubLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        githubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        githubLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        githubLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        return view
    }
}
