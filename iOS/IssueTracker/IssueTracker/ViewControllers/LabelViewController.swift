//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/10/27.
//

import UIKit

class LabelViewController: UIViewController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func touchedAddButton(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addAlertVC = segue.destination as? AddAlertViewController else { return }
        
        addAlertVC.addInputView(title: "제목", placeholder: "")
        addAlertVC.addInputView(title: "설명", placeholder: "")
        addAlertVC.addInputView(title: "색상", placeholder: "")
    }
}

// MARK: - UICollectionView Data Source

extension LabelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {
            return
        }
        if let labelName = cell.labelName.titleLabel?.text,
           let labelDescription = cell.labelDescription.text,
           let labelColor = cell.labelName.backgroundColor?.hexString {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: (labelName, labelDescription, labelColor))
        } else {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: nil)
        }
    }
}
