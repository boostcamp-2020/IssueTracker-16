//
//  ViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class IssueViewController: UIViewController {
    
    // MARK: - Constants
    
    enum State {
        case none
        case edit
    }
    
    private var issues = [Issue]()
    
    private var selectedIssues = Set<IndexPath>() {
        didSet {
            switch currentState {
                case .edit:
                    title = "\(selectedIssues.count)개 선택"
                case .none:
                    title = "이슈"
            }
        }
    }
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var interactor: IssueBusinessLogic?
    private(set) var currentState: State = .none {
        didSet {
            switch currentState {
                case .edit:
                    updateEditingMode()
                default:
                    updateDefaultMode()
            }
        }
    }
    private var swipedIndex: IndexPath?
    
    // MARK: - Views
    
    private var refreshControl = UIRefreshControl()
    @IBOutlet private weak var issueCollectionView: UICollectionView!
    @IBOutlet private weak var editBarButton: UIBarButtonItem!
    @IBOutlet private weak var filterBarButton: UIBarButtonItem!
    @IBOutlet private weak var editingToolBar: UIToolbar!
    @IBOutlet weak var addIssueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = IssueInteractor()
        setupViews()
        configureCollectionView()
        request(for: .list)
    }
    
    // MARK: - Initialize
    
    private func setupViews() {
        navigationItem.searchController = searchController
        addIssueButton.layer.cornerRadius = addIssueButton.bounds.height / 2
    }
    
    private func configureCollectionView() {
        issueCollectionView.allowsMultipleSelection = true
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        issueCollectionView.refreshControl = refreshControl
    }

    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? IssueDetailViewController {
            let sender = sender as? Issue
            vc.issue = sender
        } else if let vc = segue.destination as? AddIssueViewController {
            vc.delegate = self
        }
    }
    
    private func request(for endPoint: IssueEndPoint) {
        interactor?.request(endPoint: endPoint, completionHandler: { [weak self] (issueResponse: IssueAPI?) in
            self?.issues = issueResponse?.issues ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.issueCollectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func delete(issueID: Int, cell: UICollectionViewCell) {
        interactor?.request(endPoint: .delete(id: issueID), completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            if response.success {
                DispatchQueue.main.async {
                    guard let indexPath = self?.issueCollectionView.indexPath(for: cell) else {
                        self?.request(for: .list)
                        return
                    }
                    self?.issues.remove(at: indexPath.item)
                    self?.swipedIndex = nil
                    self?.issueCollectionView.deleteItems(at: [indexPath])
                }
            }
        })
    }
    
    // MARK: Selectors
    
    @objc private func refresh(_ sender: AnyObject) {
        request(for: .list)
        refreshControl.endRefreshing()
    }
    
    // MARK: IBActions
    
    @IBAction private func touchedEditButton(_ sender: UIBarButtonItem) {
        swipedIndex = nil
        if currentState == .edit {
            currentState = .none
        } else if currentState == .none {
            currentState = .edit
        }
        
        issueCollectionView.reloadData()
    }
        
    // MARK: Private
    
    private func updateEditingMode() {
        addIssueButton.isHidden = true
        navigationItem.searchController?.searchBar.isHidden = true
        selectedIssues = []
        tabBarController?.tabBar.isHidden = true
        editBarButton.title = "Cancel"
        filterBarButton.title = "Select All"
        editingToolBar.isHidden = false
    }
    
    private func updateDefaultMode() {
        addIssueButton.isHidden = false
        selectedIssues.removeAll()
        editBarButton.title = "Edit"
        filterBarButton.title = "Filter"
        navigationItem.searchController?.searchBar.isHidden = false
        editingToolBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func selectAllIssues() {
        for item in 0..<issues.count {
            selectedIssues.insert(IndexPath(item: item, section: 0))
        }
        
        issueCollectionView.reloadData()
    }
    
    private func cancelSwipe() {
        guard let swipedIndex = swipedIndex,
              let cell = issueCollectionView.cellForItem(at: swipedIndex)
                as? IssueListCollectionViewCell else { return }
        self.swipedIndex = nil
        cell.currentState = .none
        cell.changeNone()
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard currentState != .edit else {
            if identifier == self.segueIdentifier(to: FilterViewController.self) {
                selectAllIssues()
            }
            return false
        }
        
        return true
    }
}

extension IssueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identfier, for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
        
        
//        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
//        cell.widthAnchor.constraint(equalTo: cell.superview?.topAnchor).isActive = true
//        
        switch currentState {
            case .edit:
                cell.currentState = .edit
                
            default:
                if indexPath == swipedIndex {
                    cell.currentState = .swiped
                } else {
                    cell.currentState = .none
                }
                
                break
        }
        
        if selectedIssues.contains(indexPath) {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            cell.isSelected = false
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        cell.addSwipeGestures()
        cell.delegate = self
        cell.issue = issues[indexPath.item]
        cell.containerView.transform = .identity
        cell.deleteHandler = delete
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = .init(width: 2, height: 2)
        cell.layer.shadowOpacity = 0.3
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        
        return cell
    }
}

extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currentState == .edit else {
            performSegue(withIdentifier: segueIdentifier(to: IssueDetailViewController.self), sender: issues[indexPath.row])
            return
        }
        if !selectedIssues.contains(indexPath) {
            selectedIssues.insert(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard currentState == .edit else { return }
        if selectedIssues.contains(indexPath) {
            selectedIssues.remove(indexPath)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cancelSwipe()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
    
}

// MARK: - UICollectionView Delegate FlowLayout

extension IssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 20, height: 120)
    }
}

// MARK: - AddIssueViewControllerDelegate

extension IssueViewController: AddIssueViewControllerDelegate {
    func addIssueViewControllerDoned(_ addIssueViewController: AddIssueViewController) {
        let title = addIssueViewController.issueTitle.text ?? ""
        let content = addIssueViewController.originText ?? ""
        let newIssue = Issue(title: title, comment: Comment(content: content))
        
        interactor?.request(endPoint: .create(body: newIssue.createData), completionHandler: { (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is empty")
                return
            }
            
            if response.success {
                DispatchQueue.main.async {
                    addIssueViewController.dismiss(animated: true, completion: nil)
                    self.request(for: .list)
                }
            }
        })
    }
}

// MARK: - Swipe Controller Delegate

extension IssueViewController: SwipeControllerDelegate {
    func swipeController(_ cell: ActionCollectionViewCell) {
        switch cell.currentState {
        case .swiped:
            cell.currentState = .none
            swipedIndex = nil
            cell.changeNone()
        case .none:
            if let beforeIndex = swipedIndex,
               let beforeCell = issueCollectionView.cellForItem(at: beforeIndex) as? ActionCollectionViewCell {
                beforeCell.currentState = .none
                beforeCell.changeNone()
            }
            cell.currentState = .swiped
            cell.changeSwiped()
            guard let cell = cell as? UICollectionViewCell else { return }
            swipedIndex = issueCollectionView.indexPath(for: cell)
        default:
            return
        }
    }
}
