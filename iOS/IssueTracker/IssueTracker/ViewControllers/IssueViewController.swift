//
//  ViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/10/27.
//

import UIKit

class IssueViewController: UIViewController {
    
    // MARK: - Constants
    
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

