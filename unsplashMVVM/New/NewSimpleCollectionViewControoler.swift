//
//  NewSimpleCollectionViewControoler.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/14.
//

import UIKit
import SnapKit

class NewSimpleCollectionViewController: UIViewController {
    
    // String 타입으로 구분해도 상관없음
    // 겹치지만 않는 값으로 설정해주면 OK
    enum Section: Int, CaseIterable {
        case first = 10
        case second = 20
    }
    
    let viewModel = NewSimpleViewModel()
    
    /**
     iOS14 버전이상 컬렉션뷰를 테이블뷰처럼 사용할 수 있는 방법
     */
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    //    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    // Hashable = 고유값을 보장
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!  // UICollectionViewDiffableDataSource<섹션, 아이템>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapshot()
        viewModel.userList.bind { list in
            // 업데이트 스냅샷
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
        }
        
        collectionView.delegate = self
    }
    
    // ListConfiguration 스타일
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false           // 컬렉션뷰 구분선 보일지
        configuration.backgroundColor = .systemOrange    // 컬렉션뷰 백그라운드 색상
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func updateSnapshot() {
        // dataSource, cellRegisteration 을 모두 초기화한 이후 실행
        var snapshot = NSDiffableDataSourceSnapshot<Section,User>()
        //        snapshot.appendSections([0,1]) // 섹션 몇개넣을지 미리 설정해줘야됨 -> 0, 1 대신 100, 110 으로 세팅해도 잘동작
        
        snapshot.appendSections(Section.allCases)
        //        snapshot.appendItems(userList)
        
        //        snapshot.appendItems(userList2, toSection: 1)    // 어떤 섹션에 어떤 리스트 추가할지
        //        snapshot.appendItems(userList, toSection: 0)
        
        snapshot.appendItems(viewModel.userList.value, toSection: .first)
        snapshot.appendItems(viewModel.userList2.value, toSection: .second)
        dataSource.apply(snapshot)
    }
    
    // CollectionView iOS 14 방식
    private func configureDataSource() {
        //        collectionView.delegate = self
        //        collectionView.dataSource = self  // diffableDataSource 로 교체
        
        // UICollectionView.CellRegistration => iOS 14부터 셀을 등록하는 방법, 메서드 대신 제네릭 형태를 사용, 셀이 생성될때 마다 클로저가 호출
        // ListCell 스타일
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, User> { cell, indexPath, itemIdentifier in
            // 셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            //            content.textProperties.alignment = .center
            content.textProperties.color = .link
            content.textProperties.font = .monospacedSystemFont(ofSize: 16, weight: .black)
            content.secondaryText = "\(itemIdentifier.age)세"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .green
            content.prefersSideBySideTextAndSecondaryText = false  // true => 사이드에 사이드텍스트 나오게하기 , false => 아래로 나오게하기
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 50
            backgroundConfig.strokeWidth = 5
            backgroundConfig.strokeColor = .purple
            cell.backgroundConfiguration = backgroundConfig
        }
        
        
        // CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegisteration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        })
    }
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let user = viewModel.userList.value[indexPath.item]
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        dump(user)
        
        // 삭제기능
        //        viewModel.removeUser(index: indexPath.item)
    }
    
}

extension NewSimpleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!)
    }
}
