//
//  MainSetting.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import UIKit
import SnapKit

final class MainSettingModernCollectionViewController: UIViewController {
    
    enum Section: String, CaseIterable {
        case all = "전체 설정"
        case personal = "개인 설정"
        case etc = "기타"
    }
    
    private lazy var mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()
    )
    
    private let itemList: [String] = ["공지사항","실험실","버전정보"]
    private let itemList2: [String] = ["개인/보안","알림","채팅","멀티프로필"]
    private let itemList3: [String] = ["고객센터/도움말"]
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!  // UICollectionViewDiffableDataSource<섹션, 아이템>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // cell
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            content.textProperties.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemGray2
            cell.backgroundConfiguration = backgroundConfig
        }
        
        // section header
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            var configutation = UIListContentConfiguration.groupedHeader()
            configutation.text = Section.allCases[indexPath.section].rawValue
            configutation.textProperties.color = .systemBrown
            supplementaryView.contentConfiguration = configutation
        }
        
        // dataSource
        // CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegisteration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        })
        
        // section header 추가
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        // 스냅샷
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(itemList, toSection: .all)
        snapshot.appendItems(itemList2, toSection: .personal)
        snapshot.appendItems(itemList3, toSection: .etc)
        dataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: layoutConfig)
    }
    
    
}
