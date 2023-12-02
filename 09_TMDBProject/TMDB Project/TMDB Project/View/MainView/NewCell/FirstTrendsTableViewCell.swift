//
//  FirstTrendsTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit

class FirstTrendsTableViewCell: BaseTableViewCell {
    
    let posterImageView = UIImageView.imageBuilder()
    
    let playButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "재생"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 6
        button.configuration = config
        return button
    }()
    
    let addButton = {
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        config.title = "내가 찜한 리스트"
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 6
        button.configuration = config
        return button
    }()
    
    let stackView = UIStackView()
    
    
    var media: Result?
    
    override func configureView() {
        
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(addButton)
        
        [
            posterImageView,
            stackView
        ]
            .forEach { contentView.addSubview($0) }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(posterImageView)
            make.horizontalEdges.equalTo(posterImageView).inset(16)
            make.height.equalTo(40)
            make.bottom.equalTo(posterImageView).inset(16)
        }
        
        posterImageView.backgroundColor = .white
    }
    
    override func setConstraints() {
    }
    
    func configureCell() {
        
    }
    
    
}


