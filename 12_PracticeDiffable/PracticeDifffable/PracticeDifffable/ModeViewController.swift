//
//  ViewController.swift
//  PracticeDifffable
//
//  Created by yeoni on 2023/09/18.
//

import UIKit
import SnapKit

class ModeViewController: UIViewController {

    
    
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, ModeSetting>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
    }
    
    private func configureView() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.showsSeparators = false
        configuration.headerTopPadding = 2
        configuration.backgroundColor = .green
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }

    
    private func configureDataSource() {
        
    }

}

