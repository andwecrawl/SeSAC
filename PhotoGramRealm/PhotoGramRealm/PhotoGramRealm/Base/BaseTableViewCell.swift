//
//  BaseTableViewCell.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    // 특정 버전 이상 동작하도록 하는 친구!!
    // 잉? 근데 (*, unavailable) ??
    // 해당 구문 절대 사용될 리가 없다!
    // 이 required init은 스토리보드를 사용할 때 나오는 친구니까 해당 구문은 이용하지 않는 상태로 만들 거다!! 라고 하는 거임
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    
    func setConstraints() {}
}
