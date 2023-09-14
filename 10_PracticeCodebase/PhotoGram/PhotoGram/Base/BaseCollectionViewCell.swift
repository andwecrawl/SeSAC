//
//  BaseCollectionViewCell.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

// reusableView를 기존에 상속받고 있음
// method가 추가될 수 있는 가능성까지 고려해서!!
// snapKit의 경우 특정 상황에서는 그냥 임포트 안 해도 되는 경우가 있음 그때 왜 그러지? 하고 snapKit 내부 구조를 살펴보는 게 중요함
class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        
    }
    
    func setConstraints() {
        
    }
}
