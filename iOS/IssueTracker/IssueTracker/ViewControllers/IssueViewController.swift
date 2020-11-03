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
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = IssueInteractor()
        configure()
//        collectionView.contentSize.height = 100
//        collectionView.collectionViewLayout.collectionViewContentSize.height.const = 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        interactor?.request(endPoint: .list, completionHandler: { (issues) in
//            debugPrint("TODO: ")
//        })
    }
    

    // MARK: - Initialize
    
    private func configure() {
        navigationItem.searchController = searchController
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//        layout?.sectionFootersPinToVisibleBounds = true
//        let btn = UIButton(type: .custom)
//        
//        btn.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
//        collectionView.addSubview(btn)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        let safeArea = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            btn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
//            btn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
//            btn.widthAnchor.constraint(equalToConstant: 50),
//            btn.heightAnchor.constraint(equalToConstant: 50),
//        ])
//        btn.addTarget(self, action: #selector(test(sender:)), for: .touchUpInside)
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.sectionFootersPinToVisibleBounds
//        }
    }

    // MARK: - Methods
    
    // MARK: Selectors
    
    // MARK: IBActions
    
    @IBAction func touchedAddIssueButton(_ sender: Any) {
        // TODO: - 이슈 추가화면 push
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {
            return
        }
        print(collectionView.indexPathsForVisibleItems)
        print(collectionView.contentSize.height)
    }
}

extension IssueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath)
//        return c
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identfier, for: indexPath) as? IssueListCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

// MARK: - UICollectionView Delegate FlowLayout

extension IssueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 50)
    }
}

// MARK: - UICollectionView Delegate

extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

/*
 func addBottomSheetView() {
     let bottomSheetVC = IssueBottomSheetViewController()
     self.addChild(bottomSheetVC)
     self.view.addSubview(bottomSheetVC.view)
     bottomSheetVC.didMove(toParent: self)
     let height = view.frame.height
     let width = view.frame.width
     bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
 }
 */
