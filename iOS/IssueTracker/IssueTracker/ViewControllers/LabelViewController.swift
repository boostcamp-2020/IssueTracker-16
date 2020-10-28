//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/10/27.
//

import UIKit

class LabelViewController: UIViewController {
    
    // MARK: - Properties
    
    var labels = [Label]()
    var interactor: LabelBusinessLogic?
    
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var dummyData = [(
        name: String,
        description: String,
        color: UIColor
    )]()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels.append(Label(id: 0, name: "feature", description: "기능에 대한 레이블입니다.", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).hexString))
        labels.append(Label(id: 0, name: "bug", description: "수정할 버그에 대한 레이블입니다.", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).hexString))
        interactor = LabelInteractor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.request(endPoint: .list, completionHandler: { (labels) in
            self.labels = labels
            self.labelCollectionView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddAlertViewController else { return }
        if let sender = sender as? Label {
            vc.addInputView(title: "제목", placeholder: "", text: sender.name)
            vc.addInputView(title: "설명", placeholder: "", text: sender.description)
            vc.addInputView(title: "색상", placeholder: "", text: sender.color)
        } else {
            vc.addInputView(title: "제목", placeholder: "", text: "")
            vc.addInputView(title: "설명", placeholder: "", text: "")
            vc.addInputView(title: "색상", placeholder: "", text: "")
        }
    }
}

// MARK: - UICollectionView Data Source

extension LabelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell,
              indexPath.row < labels.count else {
            return UICollectionViewCell()
        }
        
        let label = labels[indexPath.item]
        cell.labelName.setTitle(label.name, for: .normal)
        cell.labelDescription.text = label.description
        cell.labelName.backgroundColor = UIColor(hex: label.color)
        
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout

extension LabelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 80)
    }
}

// MARK: - UICollectionView Delegate

extension LabelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < labels.count else {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: nil)
            return
        }
        let index = indexPath.row
        performSegue(withIdentifier: "presentAddAlertViewContoller", sender: labels[index])
    }
}
