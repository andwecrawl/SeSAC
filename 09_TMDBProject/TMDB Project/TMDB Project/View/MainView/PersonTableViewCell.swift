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
    let nameLabel = UILabel.labelBuilder(size: 19, weight: .bold)
    let descriptionLabel = UILabel.labelBuilder(size: 16, weight: .medium)
    let knownLabel = UILabel.labelBuilder(size: 14, weight: .regular)
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 2
        return view
    }()
    
    var people: People?
    
    override func configureView() {
        super.configureView()
        
        contentView.addSubview(outerView)
        outerView.addSubview(innerView)
        
        innerView.addSubview(profileImageView)
        innerView.addSubview(stackView)
        [nameLabel, descriptionLabel, knownLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        makeImageView(outerView: contentView, innerView: outerView)
        contentView.layer.shadowOpacity = 0.15
    }
    
    override func setConstraints() {
        outerView.backgroundColor = .white
        outerView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
        
        profileImageView.image = UIImage(named: "testImage")
        profileImageView.contentMode = .scaleToFill
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(12)
            make.width.equalTo(profileImageView.snp.height).multipliedBy(0.7)
        }
        
        stackView.layer.opacity = 0.7
        stackView.distribution = .fillProportionally
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        knownLabel.numberOfLines = 0
        knownLabel.sizeToFit()
    }
    
    func configureCell() {
        guard let people else { return }
        nameLabel.text = people.name
        descriptionLabel.text = people.descriptions
        knownLabel.text = people.knownForArr
        guard let path = people.profilePath else { return }
        let profileURL = URL.makeImageURL(imagePath: path)
        profileImageView.kf.setImage(with: profileURL)
        
        
    }
    
}
