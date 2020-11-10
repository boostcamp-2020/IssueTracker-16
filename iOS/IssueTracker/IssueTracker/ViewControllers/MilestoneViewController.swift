//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/28.
//

import UIKit

class MilestoneViewController: UIViewController {
    
    // MARK: - Properties
    
    var interactor: MilestoneBusinessLogic?
    var milestones = [Milestone]()
    var swipedIndex: IndexPath?
    
    // MARK: - Views
    
    private var refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var milestoneCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = MilestoneInteractor()
        request(for: .list)
        configureCollectionView()
    }
    
    // MARK: - Initialize
    
    private func configureCollectionView() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        milestoneCollectionView.refreshControl = refreshControl
    }
    
    // MARK: - Methods
    
    private func request(for endPoint: LabelEndPoint) {
        interactor?.request(endPoint: .list, completionHandler: { [weak self] (milestoneResponse: MilestoneAPI?) in
            
            self?.milestones = milestoneResponse?.milestones ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.milestoneCollectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        request(for: .list)
        refreshControl.endRefreshing()
    }
    private func cancelSwipe() {
        guard let beforeIndex = swipedIndex,
           let beforeCell = milestoneCollectionView.cellForItem(at: beforeIndex)
            as? ActionCollectionViewCell else { return }
        beforeCell.currentState = .none
        swipedIndex = nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cancelSwipe()
        guard let vc = segue.destination as? AddAlertViewController else { return }
        vc.delegate = self
        let milestone = sender as? Milestone
        vc.addInputView(title: "제목", placeholder: "", text: milestone?.title)
        vc.addInputView(title: "완료날짜", placeholder: "yyyy-mm-dd (선택)", text: milestone?.dueDate)
        vc.addInputView(title: "설명", placeholder: "", text: milestone?.description)
        vc.item = milestone
    }
}

// MARK: - UICollectionView Data Source

extension MilestoneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return milestones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneCollectionViewCell.identifier, for: indexPath) as? MilestoneCollectionViewCell,
              indexPath.row < milestones.count else {
            return UICollectionViewCell()
        }
        cell.containerView.transform = .identity
        cell.currentState = .none
        cell.configure(milestone: milestones[indexPath.item])
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout

extension MilestoneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 80)
    }
}

// MARK: - UICollectionView Delegate

extension MilestoneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < milestones.count else {
            performSegue(withIdentifier: "presentAddAlertViewContoller", sender: nil)
            return
        }
        let index = indexPath.row
        performSegue(withIdentifier: "presentAddAlertViewContoller", sender: milestones[index])
    }
}

extension MilestoneViewController: AddAlertViewControllerDelegate {
    func addAlertViewControllerDidCancel(_ addAlertViewController: AddAlertViewController) {
        
    }
    
    func addAlertViewController(_ addAlertViewController: AddAlertViewController, didTabAddWithItem item: Inputable?) {
        guard addAlertViewController.inputViews.count == 3,
            let title = addAlertViewController.inputViews[0].textField.text,
            let dueDate = addAlertViewController.inputViews[1].textField.text,
            let description = addAlertViewController.inputViews[2].textField.text
        else {
            return
        }
        
        let newMilestone = Milestone(title: title, dueDate: dueDate, description: description)
        let endPoint: MilestoneEndPoint
        if let milestone = item as? Milestone {
            endPoint = MilestoneEndPoint.update(id: milestone.id, body: newMilestone.jsonData)
        } else {
            endPoint = MilestoneEndPoint.create(body: newMilestone.jsonData)
        }
        
        interactor?.request(endPoint: endPoint, completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            if response.success {
                self?.request(for: .list)
            }
        })
    }
    
}

extension MilestoneViewController: SwipeControllerDelegate {
    func swipeController(_ cell: ActionCollectionViewCell) {
        switch cell.currentState {
        case .swiped:
            cell.currentState = .none
            swipedIndex = nil
        case .none:
            cancelSwipe()
            cell.currentState = .swiped
            guard let cell = cell as? UICollectionViewCell else { return }
            swipedIndex = milestoneCollectionView.indexPath(for: cell)
        default:
            return
        }
    }
}

extension MilestoneViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cancelSwipe()
    }
}
