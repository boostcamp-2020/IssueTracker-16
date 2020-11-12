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
    
    var filter = Filter() {
        didSet {
            filteredIssues = filter.filtering(issues: issues)
        }
    }
    var anyIssues: [Issue] {
        if isFiltering() {
            return filteredIssues
        } else {
            return issues
        }
    }
    private var issues = [Issue]() {
        didSet {
            filter = Filter()
        }
    }
    private var filteredIssues = [Issue]() {
        didSet {
            DispatchQueue.main.async {
                self.issueCollectionView.reloadData()
            }
        }
    }
    
    private var selectedIssues = Set<IndexPath>() {
        didSet {
            switch currentState {
                case .edit:
                    title = "\(selectedIssues.count)개 선택"
                    filterBarButton.title = selectedIssues.count != anyIssues.count
                        ? "Select All" : "Deselect All"
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
        setUpSearchController()
        addIssueButton.layer.cornerRadius = addIssueButton.bounds.height / 2
    }
    
    private func configureCollectionView() {
        issueCollectionView.allowsMultipleSelection = true
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        issueCollectionView.refreshControl = refreshControl
    }

    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cancelSwipe()
        if let vc = segue.destination as? IssueDetailViewController {
            let sender = sender as? Issue
            vc.issue = sender
        } else if let vc = segue.destination as? AddIssueViewController {
            vc.delegate = self
        } else if let vc = segue.destination as? FilterViewController {
            vc.delegate = self
            let authorNames = Array(Set(issues.compactMap{ $0.author?.id }))
            let labelNames = Array(Set(issues.flatMap{ $0.labels.map{ $0.name }}))
            vc.loadItems(authors: authorNames, labels: labelNames)
        }
    }
    
    func request(for endPoint: IssueEndPoint) {
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
                    self?.removeIssueFromCollection(indexPath: indexPath)
                }
            }
        })
    }
    private func removeIssueFromCollection(indexPath: IndexPath) {
        if isFiltering() {
            for i in 0..<issues.count {
                if issues[i].id == filteredIssues[indexPath.item].id {
                    issues.remove(at: i)
                    break
                }
            }
            debugPrint("셀 삭제 오류")
        } else {
            issues.remove(at: indexPath.item)
        }
        swipedIndex = nil
        issueCollectionView.deleteItems(at: [indexPath])
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
        guard selectedIssues.count <= anyIssues.count else { return }
        if selectedIssues.count < anyIssues.count {
            selectedIssues = Set((0..<anyIssues.count).map {
                IndexPath(item: $0, section: 0)
            })
            selectedIssues.forEach {
                issueCollectionView.selectItem(at: $0, animated: true, scrollPosition: .init())
            }
        } else {
            selectedIssues = []
            issueCollectionView.indexPathsForSelectedItems?.forEach {
                issueCollectionView.deselectItem(at: $0, animated: true)
            }
        }
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
        return anyIssues.count
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
        }
        cell.issue = anyIssues[indexPath.row]
        if selectedIssues.contains(indexPath) {
//            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
//            cell.isSelected = false
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        cell.addSwipeGestures()
        cell.delegate = self
        cell.containerView.transform = .identity
        cell.deleteHandler = delete
        return cell
    }
}

extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currentState == .edit else {
            performSegue(withIdentifier: segueIdentifier(to: IssueDetailViewController.self), sender: anyIssues[indexPath.row])
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

// MARK: - Filter Delegate

extension IssueViewController: FilterDelegate {
    func filterUpdate(types: [FilterType]) {
        filter.types = types
    }
}

// MARK: - Search Delegate

extension IssueViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        search(text)
    }
    func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Issues"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func search(_ searchText: String, scope: String = "All") {
        filteredIssues = filter.filtering(issues: issues, searchText: searchText)
        issueCollectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty() || filter.isFiltering
    }
    
}

