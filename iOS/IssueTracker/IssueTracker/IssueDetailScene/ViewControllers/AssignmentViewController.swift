//
//  AssignmentViewController.swift
//  IssueTracker
//
//  Created by 홍경표 on 2020/11/12.
//

import UIKit

enum Assign {
    case assignee
    case label
    case milestone
}

class AssignmentViewController: UIViewController {
    private typealias UserDataSource = UICollectionViewDiffableDataSource<Section, User>
    private typealias LabelDataSource = UICollectionViewDiffableDataSource<Section, Label>
    private typealias MilestoneDataSource = UICollectionViewDiffableDataSource<Section, Milestone>
    
    var issueID: Int?
    lazy var users: [User] = []
    private var selectedUsers: [User] = [] {
        didSet {
            doneButton.isEnabled = selectedUsers.count == 0 ? false : true
        }
    }
    lazy var labels: [Label] = []
    lazy var selectedLabels: [Label] = [] {
        didSet {
            doneButton.isEnabled = selectedLabels.count == 0 ? false : true
        }
    }
    lazy var milestones: [Milestone] = []
    private var selectedMilestone: Milestone? {
        didSet {
            doneButton.isEnabled = selectedMilestone == nil ? false : true
        }
    }
    
    private var interactor: AssignmentInteractor?
    private enum Section: String, CaseIterable {
        case selected = "SELECTED"
        case none = ""
    }
    
    var assignType: Assign?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let assignType = assignType else { return }
        interactor = AssignmentInteractor()
        switch assignType {
        case .assignee:
            requestUsers()
        case .label:
            requestLabels()
        case .milestone:
            requestMilestones()
        }
        createLayout()
        applySnapshot()
    }
    
    private func createLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.backgroundColor = .secondarySystemBackground
        config.headerMode = .supplementary
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        switch assignType {
        case .assignee:
            var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(users, toSection: .none)
            snapshot.appendItems(selectedUsers, toSection: .selected)
            userDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        case .label:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Label>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(labels, toSection: .none)
            snapshot.appendItems(selectedLabels, toSection: .selected)
            labelDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        case .milestone:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Milestone>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(milestones, toSection: .none)
            if let selectedMilestone = selectedMilestone {
                snapshot.appendItems([selectedMilestone], toSection: .selected)
            }
            milestoneDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        case .none:
            break
        }
    }
    
    private lazy var userCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User> { cell, indexPath, user in
        var content = cell.defaultContentConfiguration()
        if let imageUrl = user.imageUrl,
           let url = URL(string: imageUrl),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            let resizedImage = self.resizeImage(image: image, newSize: 50)
            content.image = resizedImage
        }
        content.text = user.id
        content.imageProperties.maximumSize = .init(width: 50, height: 50)
        content.imageProperties.cornerRadius = 10
        cell.contentConfiguration = content
        cell.accessories = indexPath.section == 0 ? [.label(text: "X")] : [.label(text: "+")]
    }
    private lazy var labelCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Label> { cell, indexPath, label in
        var content = cell.defaultContentConfiguration()
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        content.text = label.name
        backgroundConfig.backgroundColor = UIColor(hex: label.color)
        content.textProperties.color = UIColor(hex: label.color)?.isDarkColor ?? true ? .white : .black
        cell.contentConfiguration = content
        cell.backgroundConfiguration = backgroundConfig
    }
    private lazy var milestoneCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Milestone> { cell, indexPath, milestone in
        var content = cell.defaultContentConfiguration()
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        content.text = milestone.title
        content.secondaryText = "완료날짜: \(milestone.dueDate)"
        cell.contentConfiguration = content
        cell.backgroundConfiguration = backgroundConfig
    }
    private lazy var userDataSource: UserDataSource = {
        let dataSource = UserDataSource(collectionView: collectionView) { (collectionView, indexPath, user) -> UICollectionViewCell? in
            let userCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User> { cell, indexPath, user in
                var content = cell.defaultContentConfiguration()
                if let imageUrl = user.imageUrl,
                   let url = URL(string: imageUrl),
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    let resizedImage = self.resizeImage(image: image, newSize: 50)
                    content.image = resizedImage
                }
                content.text = user.id
                content.imageProperties.maximumSize = .init(width: 50, height: 50)
                content.imageProperties.cornerRadius = 10
                cell.contentConfiguration = content
                cell.accessories = indexPath.section == 0 ? [.label(text: "X")] : [.label(text: "+")]
            }
            return collectionView.dequeueConfiguredReusableCell(using: userCellRegistration, for: indexPath, item: user)
        }
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Header") {
            [weak self] (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self?.userDataSource.snapshot().sectionIdentifiers[indexPath.section].rawValue
            supplementaryView.label.font = UIFont.preferredFont(forTextStyle: .body)
        }
        dataSource.supplementaryViewProvider = { (view, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            }
            return nil
        }
        return dataSource
    }()
    
    private lazy var labelDataSource: LabelDataSource = {
        let dataSource = LabelDataSource(collectionView: collectionView) { (collectionView, indexPath, label) -> UICollectionViewCell? in
            let labelCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Label> { cell, indexPath, label in
                var content = cell.defaultContentConfiguration()
                var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
                content.text = label.name
                backgroundConfig.backgroundColor = UIColor(hex: label.color)
                content.textProperties.color = UIColor(hex: label.color)?.isDarkColor ?? true ? .white : .black
                content.textProperties.font = .preferredFont(forTextStyle: .headline)
                cell.contentConfiguration = content
                cell.backgroundConfiguration = backgroundConfig
            }
            return collectionView.dequeueConfiguredReusableCell(using: labelCellRegistration, for: indexPath, item: label)
        }
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Header") {
            [weak self] (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self?.labelDataSource.snapshot().sectionIdentifiers[indexPath.section].rawValue
            supplementaryView.label.font = UIFont.preferredFont(forTextStyle: .body)
        }
        dataSource.supplementaryViewProvider = { (view, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            }
            return nil
        }
        return dataSource
    }()
    private lazy var milestoneDataSource: MilestoneDataSource = {
        let dataSource = MilestoneDataSource(collectionView: collectionView) { (collectionView, indexPath, milestone) -> UICollectionViewCell? in
            let milestoneCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Milestone> { cell, indexPath, milestone in
                var content = cell.defaultContentConfiguration()
                var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
                content.text = milestone.title
                content.textProperties.font = .preferredFont(forTextStyle: .headline)
                content.secondaryText = "완료날짜: \(milestone.dueDate ?? "")"
                content.secondaryTextProperties.color = .secondaryLabel
                cell.contentConfiguration = content
                cell.backgroundConfiguration = backgroundConfig
            }
            return collectionView.dequeueConfiguredReusableCell(using: milestoneCellRegistration, for: indexPath, item: milestone)
        }
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "Header") {
            [weak self] (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self?.milestoneDataSource.snapshot().sectionIdentifiers[indexPath.section].rawValue
            supplementaryView.label.font = UIFont.preferredFont(forTextStyle: .body)
        }
        dataSource.supplementaryViewProvider = { (view, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            }
            return nil
        }
        return dataSource
    }()
    
    private func resizeImage(image: UIImage, newSize: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: newSize, height: newSize))
        image.draw(in: CGRect(x: 0, y: 0, width: newSize, height: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func touchedDone(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        switch assignType {
        case .assignee:
            let alert = UIAlertController(title: "준비 중 ⚠️", message: "다음 버전에서 뵈어요 😅\n레이블 마일스톤은 준비되었습니다 👇", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) { (action) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
//            selectedUsers.forEach{ user in
//                requestAssignAssignee(userNum: user.num)
//            }
        case .label:
            selectedLabels.forEach{ label in
                requestAssignLabel(labelNum: label.id)
            }
        case .milestone:
            if let selectedMilestone = selectedMilestone {
                requestAssignMilestone(milestoneNum: selectedMilestone.id)
            }
        default:
            return
        }
    }
    @IBAction func touchedClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AssignmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch assignType {
        case .assignee:
            if indexPath.section == 1 {
                guard let user = userDataSource.itemIdentifier(for: indexPath),
                      let index = users.firstIndex(of: user) else { return }
                selectedUsers.append(user)
                users.remove(at: index)
            } else {
                guard let user = userDataSource.itemIdentifier(for: indexPath),
                      let index = selectedUsers.firstIndex(of: user) else { return }
                users.append(user)
                selectedUsers.remove(at: index)
            }
        case .label:
            if indexPath.section == 1 {
                guard let label = labelDataSource.itemIdentifier(for: indexPath),
                      let index = labels.firstIndex(of: label) else { return }
                selectedLabels.append(label)
                labels.remove(at: index)
            } else {
                guard let label = labelDataSource.itemIdentifier(for: indexPath),
                      let index = selectedLabels.firstIndex(of: label) else { return }
                labels.append(label)
                selectedLabels.remove(at: index)
            }
        case .milestone:
            if indexPath.section == 1 {
                guard let milestone = milestoneDataSource.itemIdentifier(for: indexPath),
                      let index = milestones.firstIndex(of: milestone) else { return }
                milestones.remove(at: index)
                if let beforeSelected = selectedMilestone {
                    milestones.append(beforeSelected)
                }
                selectedMilestone = milestone
            } else {
                guard let milestone = milestoneDataSource.itemIdentifier(for: indexPath) else { return }
                milestones.append(milestone)
                selectedMilestone = nil
            }
        default:
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.applySnapshot()
        }
    }
}

// MARK: Request Datas
extension AssignmentViewController {
    private func requestUsers() {
        interactor?.request(endPoint: UserEndPoint.list, completionHandler: { [weak self] (users: [User]?) in
            self?.users = users ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.applySnapshot()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func requestLabels() {
        interactor?.request(endPoint: LabelEndPoint.list, completionHandler: { [weak self] (labels: [Label]?) in
            self?.labels = labels ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.applySnapshot()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func requestMilestones() {
        interactor?.request(endPoint: MilestoneEndPoint.list, completionHandler: { [weak self] (milestoneResponse: MilestoneAPI?) in
            self?.milestones = milestoneResponse?.milestones ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.applySnapshot()
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func requestAssignAssignee(userNum: Int) {
        guard let issueID = issueID else { return }
        let newAssignment = AssigneeAssignment(issueNum: issueID, userNum: userNum)
        interactor?.request(endPoint: UserEndPoint.assign(body: newAssignment.jsonData), completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            if response.success {
                print("assignment succeeded")
                self?.selectedUsers.removeLast()
                if self?.selectedUsers.isEmpty ?? true {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("Assigned"), object: nil)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        })
    }
    private func requestAssignLabel(labelNum: Int) {
        guard let issueID = issueID else { return }
        let newAssignment = LabelAssignment(issueNum: issueID, labelNum: labelNum)
        interactor?.request(endPoint: LabelEndPoint.assign(body: newAssignment.jsonData), completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            self?.selectedLabels.popLast()
            if self?.selectedLabels.isEmpty ?? true {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("Assigned"), object: nil)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
//            if response.success {
//                print("assignment succeeded")
//            } else {
//                self?.selectedLabels.popLast()
//            }
        })
    }
    private func requestAssignMilestone(milestoneNum: Int) {
        guard let issueID = issueID else { return }
        let newAssignment = MilestoneAssignment(milestoneNum: milestoneNum)
        interactor?.request(endPoint: MilestoneEndPoint.assign(issueID: issueID, body: newAssignment.jsonData), completionHandler: { [weak self] (response: APIResponse?) in
            guard let response = response else {
                debugPrint("response is Empty")
                return
            }
            if response.success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("Assigned"), object: nil)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}
