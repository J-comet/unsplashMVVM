//
//  NewSimpleCollectionViewControoler.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/14.
//

import UIKit
import SnapKit

class NewSimpleCollectionViewController: UIViewController {
    
    var userList = [
        User(name: "상어", age: 10),
        User(name: "고래", age: 20),
        User(name: "금붕어", age: 30),
        User(name: "장어", age: 40)
    ]
    
    /**
     iOS14 버전이상 컬렉션뷰를 테이블뷰처럼 사용할 수 있는 방법
     */
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // UICollectionView.CellRegistration => iOS 14부터 셀을 등록하는 방법, 메서드 대신 제네릭 형태를 사용, 셀이 생성될때 마다 클로저가 호출
        // ListCell 스타일
        cellRegisteration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            // 셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
//            content.textProperties.alignment = .center
            content.textProperties.color = .link
            content.textProperties.font = .monospacedSystemFont(ofSize: 16, weight: .black)
            content.secondaryText = "\(itemIdentifier.age)세"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .green
            content.prefersSideBySideTextAndSecondaryText = false  // true => 사이드에 나오게하기 , false => 아래로 나오게하기
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 50
            backgroundConfig.strokeWidth = 5
            backgroundConfig.strokeColor = .purple
            cell.backgroundConfiguration = backgroundConfig
        }
    }
    
    // ListConfiguration 스타일
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false           // 컬렉션뷰 구분선 보일지
        configuration.backgroundColor = .systemOrange    // 컬렉션뷰 백그라운드 색상
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // iOS 14
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: cellRegisteration,
            for: indexPath,
            item: userList[indexPath.item]
        )
        return cell
    }
    
}
