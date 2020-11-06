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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = LabelInteractor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        interactor?.request(endPoint: .list, completionHandler: { [weak self] (labels) in
            self?.labels = labels
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.labelCollectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddAlertViewController else { return }
        vc.delegate = self
        if let label = sender as? Label {
            vc.addInputView(title: "제목", placeholder: "", text: label.name)
            vc.addInputView(title: "설명", placeholder: "", text: label.description)
            vc.addInputView(title: "색상", placeholder: "", text: label.color)
            vc.item = label
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
        cell.configure(label: label)
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout

extension LabelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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

extension LabelViewController: AddAlertViewControllerDelegate {
    func addAlertViewControllerDidCancel(_ addAlertViewController: AddAlertViewController) {
        
    }
    
    func addAlertViewController(_ addAlertViewController: AddAlertViewController, didTabAddWithItem item: Inputable) {
        guard
            var label = item as? Label,
            let index = labels.firstIndex(of: label),
            addAlertViewController.inputViews.count == 3,
            let name = addAlertViewController.inputViews[0].textField.text,
            let description = addAlertViewController.inputViews[1].textField.text,
            let color = addAlertViewController.inputViews[2].textField.text
        else {
            return
        }
        
        label.name = name
        label.description = description
        label.color = color
        labels[index] = label
        labelCollectionView.reloadData()
    }
    
}
