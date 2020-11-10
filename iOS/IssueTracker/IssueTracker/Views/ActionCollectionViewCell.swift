//
//  ActionCollectionViewCell.swift
//  IssueTracker
//
//  Created by woong on 2020/11/04.
//

protocol ActionCollectionViewCell: class {
    var currentState: ActionState { get set }
    func changeNone()
    func changeEditMode()
    func changeSwiped()
}

enum ActionState {
    case none
    case edit
    case swiped
}

protocol SwipeControllerDelegate {
    func swipeController(_ cell: ActionCollectionViewCell)
}
