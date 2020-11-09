//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/11/05.
//

import UIKit

class IssueDetailViewController: UIViewController {

    // MARK: - Properties
    
    var issue: Issue?
    
    private var refreshControl = UIRefreshControl()
    private var titleYAnchor: NSLayoutConstraint?
    private var interactor: IssueDetailInteractor?
    // MARK: - Views
    
    @IBOutlet weak var issueDetailCollectionView: UICollectionView!
    private var bottomSheetView: UIView?
    private lazy var shadowView: UIView = {
        let shadowView = UIView(frame: self.view.frame)
        shadowView.backgroundColor = .label
        shadowView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedShadowView))
        shadowView.addGestureRecognizer(tapGesture)
        return shadowView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLogic()
        configureCollectionView()
        requestIssue()
        self.tabBarController?.tabBar.isHidden = true
        view.addSubview(shadowView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Initialize
    
    private func configureLogic() {
        interactor = IssueDetailInteractor()
    }
    
    private func configureCollectionView() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        issueDetailCollectionView.refreshControl = refreshControl
    }
    
    // MARK: - Methods
    
    private func requestIssue() {
        guard let issue = issue else { return }
        interactor?.request(endPoint: .issue(id: issue.id), completionHandler: { [weak self] (issue: Issue?) in
            self?.issue = issue
            print(issue)
            DispatchQueue.main.async {
                self?.issueDetailCollectionView.reloadData()
                self?.addBottomSheetVC()
            }
        })
    }
    
    private func presentMoreActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Selectors
    
    @objc private func refresh(_ sender: AnyObject) {
        requestIssue()
        refreshControl.endRefreshing()
    }
    
    @objc private func tappedShadowView() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            self?.moveView(state: .partial)
        })
    }
    
    // MARK: IBActions
    
    @IBAction private func touchedEditButton(_ sender: Any) {
        performSegue(withIdentifier: segueIdentifier(to: AddIssueViewController.self), sender: issue)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddIssueViewController else { return }
        let sender = sender as? Issue
        vc.issue = sender
    }
    
}

// MARK: - UICollectionView Data Source

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issue?.comments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.identifier, for: indexPath) as? CommentCollectionViewCell else { return UICollectionViewCell() }
        
        cell.comment = issue?.comments?[indexPath.item]
        cell.moreHandler = { [weak self] cell in
            self?.presentMoreActionSheet()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailHeaderView.identifier, for: indexPath) as? IssueDetailHeaderView else { return UICollectionReusableView() }
                headerView.issue = issue
                return headerView
            default:
                return UICollectionReusableView()
        }
    }
}

// MARK: UICollectionView Delegate

extension IssueDetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionView Delegate FlowLayout

extension IssueDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 172)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
}

// MARK: - Bottom Sheet

extension IssueDetailViewController {
    private enum State {
        case partial
        case full
    }
    private var fullViewPosition: CGFloat {
        guard let height = bottomSheetView?.frame.height else { return 150 }
        return view.frame.height - height
    }
    
    private var partialViewPosition: CGFloat {
        UIScreen.main.bounds.height - 120
    }
    private func addBottomSheetVC() {
        guard let bottomSheetVC: IssueBottomSheetViewController = storyboard?.instantiateViewController(identifier: IssueBottomSheetViewController.identifier) as? IssueBottomSheetViewController else { return }
        self.addChild(bottomSheetVC)
        let height = view.frame.height * 0.8
        let width = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        bottomSheetVC.delegate = self
        bottomSheetVC.author = issue?.author
        
        // FIXME: 수정수정!!!@#!@#!@#!@#
        let labelResponse = issue?.labels.first
        let label = Label(id: 0, name: labelResponse?.name ?? "", description: "", color: labelResponse?.color ?? "")
        bottomSheetVC.label = label
        bottomSheetVC.milestone = issue?.milestone
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        bottomSheetVC.view.addGestureRecognizer(gesture)
        bottomSheetView = bottomSheetVC.view
    }
    
    // MARK: - Methods
    
    private func moveView(state: State) {
        guard let bottomSheetView = bottomSheetView else { return }
        let yPosition = state == .partial ? partialViewPosition : fullViewPosition
        bottomSheetView.frame = CGRect(x: 0, y: yPosition, width: bottomSheetView.frame.width, height: bottomSheetView.frame.height)
        shadowView.alpha = state == .partial ? 0 : 0.5
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        guard let bottomSheetView = bottomSheetView else { return }
        let transition = recognizer.translation(in: bottomSheetView)
        let minY = bottomSheetView.frame.minY
        guard (minY + transition.y >= fullViewPosition) && (minY + transition.y <= partialViewPosition) else { return }
        bottomSheetView.frame = CGRect(x: 0, y: minY + transition.y, width: bottomSheetView.frame.width, height: bottomSheetView.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: bottomSheetView)
        guard minY <= (250 + fullViewPosition) else { return }
        let alpha = 0.5 - (minY - fullViewPosition) / 500.0
        shadowView.alpha = alpha
    }
    
    // MARK: PanGesture
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        guard let bottomSheetView = bottomSheetView else { return }
        guard recognizer.state == .ended else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            guard let self = self else { return }
            let state: State = bottomSheetView.frame.minY >= UIScreen.main.bounds.height / 2 ? .partial : .full
            self.moveView(state: state)
        }, completion: nil)
    }
    
}

// MARK: Bottom Sheet Delegate

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
