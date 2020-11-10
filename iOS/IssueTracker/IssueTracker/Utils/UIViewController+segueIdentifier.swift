//
//  UIViewController+segueIdentifier.swift
//  IssueTracker
//
//  Created by woong on 2020/11/05.
//

import UIKit

extension UIViewController {
    func segueIdentifier(to destination: UIViewController.Type) -> String {
        return "\(Self.self)To\(destination.self)"
    }
}
