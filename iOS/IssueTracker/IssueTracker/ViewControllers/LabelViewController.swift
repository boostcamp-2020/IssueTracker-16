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
    var swipedIndex: IndexPath?
    
    // MARK: - Views
    
    private var refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = LabelInteractor()
        request(for: .list)
        configureCollectionView()
    }
    
    // MARK: - Initialize
    
    private func configureCollectionView() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        labelCollectionView.refreshControl = refreshControl
    }
    
    // MARK: - Methods
    
    @objc private func refresh(_ sender: AnyObject) {
        request(for: .list)
        refreshControl.endRefreshing()
    }
    
    private func request(for endPoint: LabelEndPoint) {
        interactor?.request(endPoint: .list, completionHandler: { [weak self] (labels: [Label]?) in
            self?.labels = labels ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.labelCollectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func delete(labelID: Int, cell: UICollectionViewCell) {
        interactor?.request(endPoint: .delete(id: labelID), completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            if response.success {
                DispatchQueue.main.async {
                    guard let indexPath = self?.labelCollectionView.indexPath(for: cell) else {
                        self?.request(for: .list)
                        return
                    }
                    guard let cell = cell as? ActionCollectionViewCell else { return }
                    cell.currentState = .none
                    self?.labels.remove(at: indexPath.item)
                    self?.swipedIndex = nil
                    self?.labelCollectionView.deleteItems(at: [indexPath])
                }
            }
        })
    }
    
    private func cancelSwipe() {
        guard let beforeIndex = swipedIndex,
           let beforeCell = labelCollectionView.cellForItem(at: beforeIndex)
            as? ActionCollectionViewCell else { return }
        beforeCell.currentState = .none
        swipedIndex = nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cancelSwipe()
        guard let vc = segue.destination as? AddAlertViewController else { return }
        vc.delegate = self
        let label = sender as? Label
        vc.addInputView(title: "제목", placeholder: "", text: label?.name)
        vc.addInputView(title: "설명", placeholder: "", text: label?.description)
        vc.addInputView(title: "색상", placeholder: "", text: label?.color)
        vc.item = label
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
        cell.containerView.transform = .identity
        cell.currentState = .none
        cell.configure(label: labels[indexPath.item])
        cell.delegate = self
        cell.deleteHandler = delete
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
    
    func addAlertViewController(_ addAlertViewController: AddAlertViewController, didTabAddWithItem item: Inputable?) {
        guard
            addAlertViewController.inputViews.count == 3,
            let name = addAlertViewController.inputViews[0].textField.text,
            let description = addAlertViewController.inputViews[1].textField.text,
            let color = addAlertViewController.inputViews[2].textField.text
        else {
            return
        }
        
        let newLabel = Label(id: -1, name: name, description: description, color: color)
        var endPoint = LabelEndPoint.create(body: newLabel.jsonData)
        
        if let label = item as? Label {
            endPoint = LabelEndPoint.update(id: label.id, body: newLabel.jsonData)
        }
        
        interactor?.request(endPoint: endPoint, completionHandler: { [weak self] (response: APIResponse?) in
            
            guard let response = response else {
                print("response is Empty")
                return
            }
            
            if response.success {
                self?.request(for: .list)
            }
        })
    }
    
}

extension LabelViewController: SwipeControllerDelegate {
    func swipeController(_ cell: ActionCollectionViewCell) {
        switch cell.currentState {
        case .swiped:
            cell.currentState = .none
            swipedIndex = nil
        case .none:
            cancelSwipe()
            cell.currentState = .swiped
            guard let cell = cell as? UICollectionViewCell else { return }
            swipedIndex = labelCollectionView.indexPath(for: cell)
        default:
            return
        }
    }
}

extension LabelViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cancelSwipe()
    }
}
