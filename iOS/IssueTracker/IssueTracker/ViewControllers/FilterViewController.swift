//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by woong on 2020/11/05.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: Constants
    
    struct FilterItem: Hashable {
        let title: String
        var subItems: [FilterItem]
        private let identifier = UUID()
    }
    
    // MARK: Properties
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    var filterItems: [Int: [FilterItem]] = [
        0: [
                FilterItem(title: "열린 이슈들", subItems: []),
                FilterItem(title: "내가 작성한 이슈들", subItems: []),
                FilterItem(title: "나한테 할당된 이슈들", subItems: []),
                FilterItem(title: "내가 댓글을 남긴 이슈들", subItems: []),
                FilterItem(title: "닫힌 이슈들", subItems: []),
        ],
        1: [
            FilterItem(title: "작성자", subItems: [
                FilterItem(title: "웅스", subItems: []),
                FilterItem(title: "피오", subItems: [])
            ]),
            FilterItem(title: "레이블", subItems: [
                FilterItem(title: "iOS", subItems: []),
                FilterItem(title: "BE", subItems: [])
            ])
        ]
    ]
    var sectionTitle: [Int: String] = [
        0: "다음 조건 중에 고르세요",
        1: "세부 조건"
    ]
    private var dataSource: UICollectionViewDiffableDataSource<Int, FilterItem>! = nil

    // MARK: Views
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    // MARK: Initialize
    
    func configureCollectionView() {
        filterCollectionView.collectionViewLayout = generateLayout()
        filterCollectionView.allowsMultipleSelection = true
    }
    
    func configureDataSource() {
        
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FilterItem> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            
        }
        
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FilterItem> { (cell, indexPath, menuItem) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration
            
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options:disclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        let cellRegistration = UICollectionView.CellRegistration<FilterCollectionViewListCell, FilterItem> { cell, indexPath, filterItem in
            
            
            cell.filterItem = filterItem
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, FilterItem>(collectionView: filterCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            if item.subItems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        })
        
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Header") {
            [weak self] (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self?.sectionTitle[indexPath.section]
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            if kind == UICollectionView.elementKindSectionHeader {
                return self.filterCollectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: index)
            }
            return nil
        }
        
        applySnapshot()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        listConfiguration.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSectionSnapshot<FilterItem>()
        
        func addItems(_ filterItems: [FilterItem], to parent: FilterItem?) {
            snapshot.append(filterItems, to: parent)
            for filterItem in filterItems where !filterItem.subItems.isEmpty {
                addItems(filterItem.subItems, to: filterItem)
            }
        }
        
        for (section, items) in filterItems.sorted(by: { $0.key < $1.key }) {
            snapshot = NSDiffableDataSourceSectionSnapshot<FilterItem>()
            
//            let headerItem = FilterItem(title: sectionTitle[section] ?? "", subItems: [])
            // snapshot.append([headerItem])
            addItems(items, to: nil)
            dataSource.apply(snapshot, to: section, animatingDifferences: false, completion: nil)
        }
    }
}
