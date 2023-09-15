//
//  StudyModernCollectionViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import UIKit
import SnapKit

/**
 iOS 14 버전부터 CollectionView 다루는 법
 1. 컬렉션뷰 레이아웃 잡기
 2. ListConfiguration (CollectionViewLayout) 함수 추가
 3. DiffableDataSource 추가
 4. Snapshot 추가
 */

final class StudyModernCollectionViewController: UIViewController {
    
    private let list = ["disclosureIndicator", "outlineDisclosure", "checkmark", "delete", "insert", "multiselect", "label", "customView"]
    private let list2 = ["모든 기기에서 공유"]
    
    private lazy var settingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!  // UICollectionViewDiffableDataSource<섹션, 아이템>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(settingCollectionView)
        settingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 셀 디자인 및 데이터 처리
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .white
            content.textProperties.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
            content.secondaryText = "켬"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .green
            content.prefersSideBySideTextAndSecondaryText = true  // true => 사이드에 SecondaryText 나오게하기 , false => 아래로 나오게하기
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            // accessory
            if indexPath.section == 0 {
                switch indexPath.item {
                case 0:
                    cell.accessories = [.disclosureIndicator(displayed: .always)]
                case 1:
                    cell.accessories = [.outlineDisclosure()]
                case 2:
                    cell.accessories = [.checkmark()]
                case 3:
                    cell.accessories = [.delete(displayed: .whenNotEditing)]
                case 4:
                    cell.accessories = [.insert(displayed: .always)]
                case 5:
                    cell.accessories = [.reorder(displayed: .always)]
                case 6:
                    cell.accessories = [.multiselect(displayed: .always)]
                case 7:
                    cell.accessories = [.label(text: "레이블모드")]
                default:
                    cell.accessories = [.outlineDisclosure()]
                    break
                }
            }
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .systemGray2
            //            backgroundConfig.cornerRadius = 10
            //            backgroundConfig.strokeWidth = 2
            //            backgroundConfig.strokeColor = .purple
            cell.backgroundConfiguration = backgroundConfig
        }
        
        // CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: settingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegisteration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0,1])
        snapshot.appendItems(list, toSection: 0)
        snapshot.appendItems(list2, toSection: 1)
        dataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //        ListConfiguration
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true           // 컬렉션뷰 구분선 보일지
        configuration.backgroundColor = .black    // 컬렉션뷰 백그라운드 색상
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
