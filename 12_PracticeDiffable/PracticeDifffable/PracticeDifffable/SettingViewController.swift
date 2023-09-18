//
//  SettingViewController.swift
//  PracticeDifffable
//
//  Created by yeoni on 2023/09/18.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        
        configureDataSource()
    }
    
    private func configureView() {
        navigationItem.title = "설정"
        
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.headerTopPadding = 10
        configuration.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    
    
}

extension SettingViewController {
    
    func configureDataSource() {

//        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Item> { cell, indexPath, itemIdentifier in
//            var content = UIListContentConfiguration.valueCell()
//            content.text = itemIdentifier.title
//            cell.contentConfiguration = content
//        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Item> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.sidebarCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .white
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
//        let settingElement = [firstElement, secondElement, thirdElement]
//        var snapshot = NSDiffableDataSourceSnapshot<Item, Item>()
//        snapshot.appendSections(sectionTitle)
//        dataSource.apply(snapshot, animatingDifferences: false)
//        for index in sectionTitle.indices {
//            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
//            sectionSnapshot.append(sectionTitle)
//            sectionSnapshot.append(settingElement[index], to: sectionTitle[index])
//            sectionSnapshot.expand(sectionTitle)
//            dataSource.apply(sectionSnapshot, to: sectionTitle[index])
//        }
//        snapshot.appendItems(firstElement, toSection: sectionTitle[0])
//        snapshot.appendItems(secondElement, toSection: sectionTitle[1])
//        snapshot.appendItems(thirdElement, toSection: sectionTitle[2])
//        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
//        sectionSnapshot.append(sectionTitle)
//        sectionSnapshot.expand(sectionTitle)
//        dataSource.apply(snapshot)
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        let sections = Array(0..<5)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = Item(title: "Section \(section)")
            sectionSnapshot.append([headerItem])
            let items = Array(0..<3).map { Item(title: "Item \($0)") }
            sectionSnapshot.append(items, to: headerItem)
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
    }
    

    
    
}

