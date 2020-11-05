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
    
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let label = UILabel()
//        titleLabel = label
//        // label.isHidden = true
//        label.text = "TEST"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        navigationController!.navigationBar.addSubview(label)
//        label.centerXAnchor.constraint(equalTo: navigationController!.navigationBar.centerXAnchor).isActive = true
//        titleYAnchor = label.centerYAnchor.constraint(equalTo: navigationController!.navigationBar.centerYAnchor, constant: navigationController!.navigationBar.frame.height)
//        titleYAnchor?.isActive = true
//
//
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationItem.largeTitleDisplayMode = .never
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.navigationBar.prefersLargeTitles = false
        // navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let headerFrame = issueDetailCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))?.frame else { return }
//
//        let headerMaxY = view.convert(headerFrame, from: issueDetailCollectionView).maxY
//        let ratio = headerMaxY / navigationController!.navigationBar.frame.height
//        titleYAnchor?.constant = min(0, titleYAnchor!.constant - ratio)
//        // print(titleYAnchor!.constant)
        
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
