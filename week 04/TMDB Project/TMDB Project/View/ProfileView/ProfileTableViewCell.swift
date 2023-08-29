//
//  ProfileTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let settingLabel = UILabel.labelBuilder(size: 15, weight: .medium)
    
    let textField = {
        let view = UITextField()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    
    override func configureView() {
        addSubview(settingLabel)
        addSubview(textField)
    }
    
    override func setConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(90)
        }
        textField.snp.makeConstraints { make in
            make.leading.equalTo(settingLabel.snp.trailing).offset(12)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(settingLabel)
        }
    }
    
    func configureCell() {
        
    }
}
