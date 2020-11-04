//
//  ViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class IssueViewController: UIViewController {
    
    // MARK: - Constants
    
    private var issues: [Issue] {
        var issues = [Issue]()
        for i in 0..<20 {
            issues.append(Issue(id: i, title: "이슈 탭을 완성합시다"))
        }
        return issues
    }
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var interactor: IssueBusinessLogic?
    
    // MARK: - Views
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = IssueInteractor()
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        interactor?.request(endPoint: .list, completionHandler: { (issues) in
//            debugPrint("TODO: ")
//        })
    }
    

    // MARK: - Initialize

    // MARK: - Methods
    
    // MARK: Selectors
    
    // MARK: IBActions
    
    @IBAction func touchedAddIssueButton(_ sender: Any) {
        // TODO: - 이슈 추가화면 push
    }
}

extension IssueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identfier, for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

extension IssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 120)
    }
}
