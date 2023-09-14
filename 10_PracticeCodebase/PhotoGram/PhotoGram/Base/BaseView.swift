//
//  BaseView.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    // 여기에 required init을 적어두면서 앞으로 적어주지 않아도 될 거잉
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
    
    func setConstraints() { }
}
