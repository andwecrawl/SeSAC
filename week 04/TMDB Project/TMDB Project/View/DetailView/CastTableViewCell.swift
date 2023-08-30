//
//  CastTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/30.
//

import UIKit

class CastTableViewCell: BaseTableViewCell {
    
    let profileImageView = UIImageView.imageBuilder()
    let nameLabel = UILabel.labelBuilder(size: 16, weight: .bold)
    let characterLabel = UILabel.labelBuilder(size: 14, weight: .light, color: .darkGray)
    
    let stackView = {
        let view = UIStackView()
        view.spacing = 4
        view.alignment = .fill
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    override func awakeFromNib() {
        nameLabel.text = "정보를 찾을 수 없습니다."
        characterLabel.text = "정보를 찾을 수 없습니다."
        profileImageView.image =  UIImage(named: "noImage")
    }
    
    override func prepareForReuse() {
        nameLabel.text = "정보를 찾을 수 없습니다."
        characterLabel.text = "정보를 찾을 수 없습니다."
        profileImageView.image =  UIImage(named: "noImage")
    }
    
    var actors: CastElement? {
        didSet {
            guard let actors else { return }
            
            if let character = actors.character {
                characterLabel.text = character
            } else {
                characterLabel.text = "캐릭터를 불러올 수 없습니다."
            }
            if actors.originalName.isEmpty {
                nameLabel.text = "배우 이름을 불러올 수 없습니다."
            } else {
                nameLabel.text = actors.originalName
            }
            
            guard let profilePath = actors.profilePath else {
                profileImageView.image = UIImage(named: "noImage")
                return
            }
            let url = URL.makeImageURL(imagePath: profilePath)
            profileImageView.kf.setImage(with: url)
        }
    }
    
    override func configureView() {
        print(#function)
        addSubview(profileImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(characterLabel)
    }
    
    override func setConstraints() {
        print(#function)
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(14)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(stackView.snp.leading).offset(-12)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1.3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    
}
