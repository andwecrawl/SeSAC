//
//  RefactorViewController.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/14.
//

import UIKit
import RealmSwift

class RefactorViewController: BaseViewController {
    
    let refCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, DiaryTable>!
    
    var tasks: Results<DiaryTable>!
    let repository = DiaryTableRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = repository.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refCollectionView.reloadData()
    }
    
    override func configure() {
        view.addSubview(refCollectionView)
        registCell()
        refCollectionView.delegate = self
        refCollectionView.dataSource = self
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        refCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
        // reloadData
    }
    
    @objc func backupButtonClicked() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    func registCell() {
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = "\(itemIdentifier.title)"
            content.textProperties.color = .yellow
            content.secondaryAttributedText = NSAttributedString(string: "\(itemIdentifier.content!)", attributes: [.foregroundColor: UIColor.white])
            self.makeImage(imageURL: itemIdentifier.photo) { image in
                content.image = image
            }
            content.imageProperties.maximumSize = CGSize(width: 150, height: 150)
//            content.textToSecondaryTextVerticalPadding = 10
//            content.textToSecondaryTextHorizontalPadding = 10
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .darkGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeColor = .cyan
            backgroundConfig.strokeWidth = 1
            cell.backgroundConfiguration = backgroundConfig
            
        }
    }
    
    func makeImage(imageURL: String?, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL else { return }
        
        if let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
}

extension RefactorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.data = tasks[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
