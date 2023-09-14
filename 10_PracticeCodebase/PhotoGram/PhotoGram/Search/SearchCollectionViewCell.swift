//
//  SearchCollectionViewCell.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    // init과 required가 base에 생성되어 있어서 없어도 댐
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleToFill
        return view
    }()
    
    
    override func configureView() {
        contentView.addSubview(imageView)
        
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
