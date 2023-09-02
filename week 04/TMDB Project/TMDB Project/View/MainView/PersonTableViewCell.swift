//
//  PersonTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/09/03.
//

import UIKit

class PersonTableViewCell: BaseTableViewCell {
    
    let innerView = UIView()
    let outerView = UIView()
    
    let profileImageView = UIImageView.imageBuilder()
    let nameLabel = UILabel.labelBuilder(size: 20, weight: .bold)
    let knownForLabel = UILabel.labelBuilder(size: 16, weight: .light)
    let genderLabel = UILabel.labelBuilder(size: 16, weight: .light)
    let popularityLabel = UILabel.labelBuilder(size: 16, weight: .light)
    let knownLabel = UILabel.labelBuilder(size: 16, weight: .light)
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 2
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        addSubview(outerView)
        outerView.addSubview(innerView)
        
        innerView.addSubview(profileImageView)
        innerView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(knownForLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(popularityLabel)
        stackView.addArrangedSubview(knownLabel)
        
        makeImageView(outerView: outerView, innerView: innerView)
    }
    
    override func setConstraints() {
        outerView.backgroundColor = .lightGray
        outerView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        innerView.backgroundColor = .red
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(outerView).inset(12)
        }
        
//        profileImageView.image = UIImage(named: "testImage")
        profileImageView.backgroundColor = .black
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
//            make.trailing.equalTo(stackView.snp.leading)
            make.width.equalTo(120)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1.3)
        }
        
        stackView.backgroundColor = .yellow
        stackView.layer.opacity = 0.7
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
}
