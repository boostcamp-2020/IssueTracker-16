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
        var type: FilterType?
    }
    static private let me = "seokju2ng"
    
    // MARK: Properties
    
    static private let sectionHeaderElementKind = "section-header-element-kind"
    private var filterItems: [Int: [FilterItem]] = [
        0: [
            FilterItem(title: "열린 이슈들", subItems: [], type: .isClosed(false)),
            FilterItem(title: "내가 작성한 이슈들", subItems: [], type: .author(me)),
            FilterItem(title: "나한테 할당된 이슈들", subItems: [], type: .assignee(me)),
            FilterItem(title: "내가 댓글을 남긴 이슈들", subItems: [], type: .commented(me)),
            FilterItem(title: "닫힌 이슈들", subItems: [], type: .isClosed(true)),
        ],
        1: [
        ]
    ]
    private let sectionTitle: [Int: String] = [
        0: "다음 조건 중에 고르세요",
        1: "세부 조건"
    ]
    private var dataSource: UICollectionViewDiffableDataSource<Int, FilterItem>! = nil
    var delegate: FilterDelegate?
    
    // MARK: Views
    
    @IBOutlet private weak var filterCollectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    // MARK: Initialize
    
    func loadItems(authors: [String], labels: [String]) {
        let authors = authors.map{FilterItem(title: $0, subItems: [], type: .author($0))}
        let authorFilter = FilterItem(title: "작성자", subItems: authors)
        let labels = labels.map{FilterItem(title: $0, subItems: [], type: .label($0))}
        let labelFilter = FilterItem(title: "레이블", subItems: labels)
        filterItems[1] = [authorFilter, labelFilter]
    }
    
    private func configureCollectionView() {
        filterCollectionView.collectionViewLayout = generateLayout()
        filterCollectionView.allowsMultipleSelection = true
    }
    
    private func configureDataSource() {
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
        filterCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSectionSnapshot<FilterItem>()
        
        func addItems(_ filterItems: [FilterItem], to parent: FilterItem?) {
            snapshot.append(filterItems, to: parent)
            for filterItem in filterItems where !filterItem.subItems.isEmpty {
                addItems(filterItem.subItems, to: filterItem)
            }
        }
        
        for (section, items) in filterItems.sorted(by: { $0.key < $1.key }) {
            snapshot = NSDiffableDataSourceSectionSnapshot<FilterItem>()
            
            addItems(items, to: nil)
            dataSource.apply(snapshot, to: section, animatingDifferences: false, completion: nil)
        }
        
    }
    
    // MARK: - Methods
    
    @IBAction private func touchedDone(_ sender: Any) {
        guard let indexPaths = filterCollectionView.indexPathsForSelectedItems else { return }
        var types: [FilterType] = []
        for indexPath in indexPaths {
            if let cell = filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewListCell,
               let type = cell.filterItem?.type {
                types.append(type)
            }
        }
        delegate?.filterUpdate(types: types)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchedClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Filter
enum FilterType: Hashable {
    case label(String)
    case author(String)
    case isClosed(Bool)
    case assignee(String)
    case commented(String)
    var condition: (Issue) -> Bool {
        switch self {
        case .label(let name):
            return { (issue) in
                for label in issue.labels {
                    if label.name == name { return true }
                }
                return false
            }
        case .author(let id):
            return { (issue) in
                issue.author?.id == id
            }
        case .isClosed(let isClosed):
            return { (issue) in
                return issue.isClosed == isClosed
            }
        case .assignee(let id):
            return { (issue) in
                for assignee in issue.assignees {
                    if assignee.id == id { return true }
                }
                return false
            }
        case .commented(let id):
            return { (issue) in
                for comment in issue.comments ?? [] {
                    if comment.writer?.id == id { return true}
                }
                return false
            }
        }
    }
    
}
// TODO: 필터 조건 조합 로직 수정!!!!!!!
struct Filter {
    var types: [FilterType]
    func filtering(issues: [Issue]) -> [Issue] {
        return issues.filter({
            for type in types {
                if type.condition($0) { return true }
            }
            return false
        })
    }
    var isFiltering: Bool {
        guard types.count == 1, types[0] == .isClosed(false) else { return true }
        return false
    }
    init() {
        types = [FilterType.isClosed(false)]
    }
}
protocol FilterDelegate {
    func filterUpdate(types: [FilterType])
}
