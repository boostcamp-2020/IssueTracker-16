//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/11/05.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet weak var issueDetailCollectionView: UICollectionView!
    
    var titleYAnchor: NSLayoutConstraint?
    
    
    var issue: Issue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        addBottomSheetVC()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func addBottomSheetVC() {
        let bottomSheetVC = self.storyboard?.instantiateViewController(identifier: IssueBottomSheetViewController.identifier) as! IssueBottomSheetViewController
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        let height = view.frame.height
        let width = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
        bottomSheetVC.delegate = self
        bottomSheetVC.author = issue?.author
        bottomSheetVC.label = issue?.labels.first
        bottomSheetVC.milestone = issue?.milestone
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let headerFrame = issueDetailCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))?.frame else { return }
//
//        let headerMaxY = view.convert(headerFrame, from: issueDetailCollectionView).maxY
//        let ratio = headerMaxY / navigationController!.navigationBar.frame.height
//        titleYAnchor?.constant = min(0, titleYAnchor!.constant - ratio)
//        // print(titleYAnchor!.constant)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddIssueViewController else { return }
        let sender = sender as? Issue
        vc.issue = sender
    }
    @IBAction func touchedEditButton(_ sender: Any) {
        performSegue(withIdentifier: segueIdentifier(to: AddIssueViewController.self), sender: issue)
    }
}

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.identifier, for: indexPath) as? CommentCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailHeaderView.identifier, for: indexPath) as? IssueDetailHeaderView else { return UICollectionReusableView() }
                headerView.titleLabel.text = issue?.title
                headerView.numberLabel.text = "#\(issue?.id ?? 0)"
                headerView.authorLabel.text = issue?.author.id
                return headerView
            default:
                return UICollectionReusableView()
        }
    }
}

extension IssueDetailViewController: UICollectionViewDelegate {
    
}

extension IssueDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 172)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
}

protocol BottomSheetDelegate {
    func moveToUp()
    func moveToDown()
}
extension IssueDetailViewController: BottomSheetDelegate {
    func moveToUp() {
        guard
            var minIndexPath = issueDetailCollectionView.indexPathsForVisibleItems.min(),
            let cell = issueDetailCollectionView.cellForItem(at: minIndexPath)
        else {
            return
        }
        
        let isCompletlyVisible = issueDetailCollectionView.bounds.contains(cell.frame)
        if isCompletlyVisible, minIndexPath.item > 0 {
            minIndexPath.item -= 1
        }
        issueDetailCollectionView.scrollToItem(at: minIndexPath, at: .top, animated: true)
    }
    
    func moveToDown() {
        guard
            var maxIndexPath = issueDetailCollectionView.indexPathsForVisibleItems.max(),
            let cell = issueDetailCollectionView.cellForItem(at: maxIndexPath)
        else {
            return
        }
        
        let isCompletlyVisible = issueDetailCollectionView.bounds.contains(cell.frame)
        if isCompletlyVisible, maxIndexPath.item < 20 {
            maxIndexPath.item += 1
        }
        issueDetailCollectionView.scrollToItem(at: maxIndexPath, at: .bottom, animated: true)
    }
}
