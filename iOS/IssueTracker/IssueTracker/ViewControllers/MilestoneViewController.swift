//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class MilestoneViewController: UIViewController {
    
    // MARK: - Properties
    
    var dummyData = [(
        name: String,
        description: String,
        dueDate: String,
        openIssues: Int,
        closedIssues: Int
    )]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyData = [
            ("스프린트2", "이번 배포를 위한 스프린트", "2020-06-19", 13, 23),
            ("스프린트3", "다음 배포를 위한 스프린트", "2020-06-26", 0, 0)
        ]
    }
    
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
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneCollectionViewCell.identifier, for: indexPath) as? MilestoneCollectionViewCell,
              indexPath.row < dummyData.count else {
            return UICollectionViewCell()
        }
        let index = indexPath.row
        cell.configure(
            name: dummyData[index].name,
            description: dummyData[index].description,
            dueDate: dummyData[index].dueDate,
            openIssues: dummyData[index].openIssues,
            closedIssues: dummyData[index].closedIssues
        )
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
        guard indexPath.row < dummyData.count else {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: nil)
            return
        }
        let index = indexPath.row
        performSegue(withIdentifier: "presentAddAlertViewContoller", sender: (
            dummyData[index].name,
            dummyData[index].dueDate,
            dummyData[index].description
        ))
    }
}
