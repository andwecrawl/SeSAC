//
//  SearchCollectionViewCell.swift
//  SeSACWeek10
//
//  Created by yeoni on 2023/09/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    // codebase로 실행할 때 실행되는 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // storyboard로 실행할 때 실행되는 초기화 구문
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.text = "테스트"
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
