//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class MilestoneViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

// MARK: - UICollectionView Data Source

extension MilestoneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneCollectionViewCell.identifier, for: indexPath) as? MilestoneCollectionViewCell else {
            return UICollectionViewCell()
        }
        let index = indexPath.row
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout

extension MilestoneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 80)
    }
}
