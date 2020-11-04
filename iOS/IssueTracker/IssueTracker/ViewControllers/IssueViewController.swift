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
    
    private var issues: [Issue] {
        var issues = [Issue]()
        for i in 0..<20 {
            issues.append(Issue(id: i, title: "이슈 탭을 완성합시다"))
        }
        return issues
    }
    
    private var selectedIssues = Set<IndexPath>()
    
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
    
    @IBOutlet private weak var issueCollectionView: UICollectionView!
    @IBOutlet private weak var editBarButton: UIBarButtonItem!
    @IBOutlet private weak var filterBarButton: UIBarButtonItem!
    @IBOutlet private weak var editingToolBar: UIToolbar!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = IssueInteractor()
        navigationItem.searchController = searchController
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        interactor?.request(endPoint: .list, completionHandler: { (issues) in
//            debugPrint("TODO: ")
//        })
    }

    // MARK: - Initialize
    
    private func configureCollectionView() {
        issueCollectionView.allowsMultipleSelection = true
    }

    // MARK: - Methods
    
    // MARK: Selectors
    
    // MARK: IBActions
    
    @IBAction private func touchedAddIssueButton(_ sender: Any) {
        // TODO: - 이슈 추가화면 push
    }
    
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
        editBarButton.title = "Cancel"
        filterBarButton.title = "Select All"
        navigationItem.searchController = nil
        editingToolBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    private func updateDefaultMode() {
        selectedIssues.removeAll()
        editBarButton.title = "Edit"
        filterBarButton.title = "Filter"
        navigationItem.searchController = searchController
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
            selectAllIssues()
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
                cell.currentState = .none
        }
        
        
        
        if selectedIssues.contains(indexPath) {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            cell.isSelected = false
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        return cell
    }
}

extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard currentState == .edit else { return }
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

extension IssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 120)
    }
}
