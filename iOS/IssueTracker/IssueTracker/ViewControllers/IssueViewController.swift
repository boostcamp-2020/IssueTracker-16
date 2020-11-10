//
//  ViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

protocol SwipeControllerDelegate {
    func swipeController(_ cell: IssueListCollectionViewCell)
}

class IssueViewController: UIViewController, SwipeControllerDelegate {
    func swipeController( _ cell: IssueListCollectionViewCell) {
        if let swipedIndex = swipedIndex,
              let beforeCell = issueCollectionView.cellForItem(at: swipedIndex) as? IssueListCollectionViewCell {
        
            beforeCell.currentState = .none
            beforeCell.changeNone()
        }
        
        cell.currentState = .swiped
        cell.changeSwiped()
        swipedIndex = cell.indexPath
    }
    
    private var swipedIndex: IndexPath?
    
    // MARK: - Constants
    
    enum State {
        case none
        case edit
    }
    
    private var issues = [Issue]()
    
    private var selectedIssues = Set<IndexPath>() {
        didSet {
            if currentState == .none {
                title = "이슈"
            } else {
                title = "\(selectedIssues.count)개 선택"
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
    
    // MARK: Selectors
    
    @objc private func refresh(_ sender: AnyObject) {
        request(for: .list)
        refreshControl.endRefreshing()
    }
    
    // MARK: IBActions
    
    @IBAction private func touchedEditButton(_ sender: UIBarButtonItem) {
        
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
        navigationItem.title = "\(selectedIssues.count)개 선택"
        tabBarController?.tabBar.isHidden = true
        editBarButton.title = "Cancel"
        filterBarButton.title = "Select All"
        editingToolBar.isHidden = false
    }
    
    private func updateDefaultMode() {
        addIssueButton.isHidden = false
        navigationItem.title = "이슈"
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
        cell.indexPath = indexPath
        cell.delegate = self
        cell.issue = issues[indexPath.item]
        
        
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
}

// MARK: - UICollectionView Delegate FlowLayout

extension IssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 120)
    }
}

// MARK: - AddIssueViewControllerDelegate

extension IssueViewController: AddIssueViewControllerDelegate {
    func addIssueViewControllerDoned(_ addIssueViewController: AddIssueViewController) {
        let title = addIssueViewController.issueTitle.text ?? ""
        let content = addIssueViewController.commentTextView.text ?? ""
        let newIssue = Issue(title: title, content: content)
        
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
