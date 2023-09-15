//
//  ShoppingModernCollectionViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import UIKit
import SnapKit

final class ShoppingModernCollectionViewController: UIViewController {
    
    private let inputTextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실 건가요?"
        return view
    }()
    
    private lazy var addButton = {
        let view = UIButton()
        var attString = AttributedString("추가")
        attString.font = .systemFont(ofSize: 16, weight: .bold)
        attString.foregroundColor = .black
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseBackgroundColor = .lightGray
        view.configuration = config
        view.addTarget(self, action: #selector(self.addButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()
    )
    
    private var shoppings: [Shopping] = [
        Shopping(content: "1번", isSelected: true),
        Shopping(content: "2번", isSelected: false),
        Shopping(content: "3번", isSelected: true),
        Shopping(content: "4번", isSelected: false)
    ]
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Shopping>!  // UICollectionViewDiffableDataSource<섹션, 아이템>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        shoppingCollectionView.delegate = self
        setConstraints()
        
        // cell
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, Shopping> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier.content
            content.textProperties.color = .white
            content.textProperties.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
            content.image = itemIdentifier.isSelected ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
            content.imageProperties.tintColor = .link
            cell.contentConfiguration = content
            
            let image = UIImage(systemName: "star.fill")
            let accessoryConfiguration = UICellAccessory.CustomViewConfiguration(
                customView: UIImageView(image: image),
                placement: .trailing(displayed: .always),
                tintColor: .systemYellow
            )
            cell.accessories = [.customView(configuration: accessoryConfiguration)]
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemGray2
            cell.backgroundConfiguration = backgroundConfig
        }
        
        // dataSource
        // CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: shoppingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegisteration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        })
        
        updateData()
    }
    
    private func updateData() {
        // 스냅샷
        var snapshot = NSDiffableDataSourceSnapshot<Int, Shopping>()
        snapshot.appendSections([0])
        snapshot.appendItems(shoppings, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    @objc func addButtonClicked() {
        print(#function)
        
        guard let input = inputTextField.text else {
            return
        }
        
        let newItem = Shopping(content: input, isSelected: false)
        shoppings.append(newItem)
        updateData()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true           // 컬렉션뷰 구분선 보일지
        configuration.backgroundColor = .systemGray5    // 컬렉션뷰 백그라운드 색상
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func setConstraints() {
        view.addSubview(inputTextField)
        view.addSubview(addButton)
        view.addSubview(shoppingCollectionView)
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(inputTextField)
            make.height.equalTo(50)
        }
        
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ShoppingModernCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
