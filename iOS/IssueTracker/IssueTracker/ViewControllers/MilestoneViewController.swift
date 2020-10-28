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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddAlertViewController else { return }
        if let sender = sender as? (name: String, dueDate: String, description: String) {
            vc.addInputView(title: "제목", placeholder: "", text: sender.name)
            vc.addInputView(title: "완료날짜", placeholder: "yyyy-mm-dd (선택)", text: sender.dueDate)
            vc.addInputView(title: "설명", placeholder: "", text: sender.description)
        } else {
            vc.addInputView(title: "제목", placeholder: "", text: "")
            vc.addInputView(title: "완료날짜", placeholder: "yyyy-mm-dd (선택)", text: "")
            vc.addInputView(title: "설명", placeholder: "", text: "")
        }
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

// MARK: - UICollectionView Delegate

extension MilestoneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: nil)
    }
}
