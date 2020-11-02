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
    
    // MARK: - Views
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
    }

    // MARK: - Initialize

    // MARK: - Methods
    
    // MARK: Selectors
    
    // MARK: IBActions
    
}

