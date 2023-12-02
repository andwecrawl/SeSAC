//
//  TrendTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import Kingfisher

class TrendTableViewCell: BaseTableViewCell {
    
    let dateLabel = UILabel.labelBuilder(size: 14, weight: .light)
    let genreLabel = UILabel.labelBuilder(size: 17, weight: .bold)
    
    let backdropImageView = UIImageView.imageBuilder()
    let titleLabel = UILabel.labelBuilder(size: 18, weight: .bold)
    let originalTitleLabel = UILabel.labelBuilder(size: 18, weight: .bold)
    let overviewLabel = UILabel.labelBuilder(size: 13, weight: .medium)
    
    let innerView = {
        let view = UIView()
        return view
    }()
    
    let outerView = {
        let view = UIView()
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return view
    }()
    let detailLabel = UILabel.labelBuilder(size: 12, weight: .regular, color: .darkGray)
    let arrowImageView = UIImageView.imageBuilder()
    
    var media: Result?
    var genre: [String]?
    
    
    override func configureView() {
        addSubview(dateLabel)
        addSubview(genreLabel)
        
        addSubview(outerView)
        outerView.addSubview(innerView)
        innerView.addSubview(backdropImageView)
        innerView.addSubview(titleLabel)
        innerView.addSubview(originalTitleLabel)
        innerView.addSubview(overviewLabel)
        
        innerView.addSubview(lineView)
        innerView.addSubview(detailLabel)
        innerView.addSubview(arrowImageView)
    }
    
    
    override func setConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(genreLabel.snp.top)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(dateLabel)
        }
        
//        innerView.backgroundColor = .white
        makeImageView(outerView: outerView, innerView: innerView)
        outerView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(20)
            
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        innerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(125)
        }
        
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: Float(751)), for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: Float(250)), for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(originalTitleLabel.snp.leading).inset(8)
            make.height.equalTo(20)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
        
        overviewLabel.numberOfLines = 2
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        detailLabel.text = "자세히 보기"
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(arrowImageView)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(arrowImageView).offset(8)
        }
        
        arrowImageView.image = UIImage(systemName: "greaterthan")
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(20)
            make.width.equalTo(arrowImageView.snp.height).multipliedBy(0.5)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(14)
            make.top.equalTo(detailLabel.snp.top).offset(-10)
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = ""
        originalTitleLabel.text = ""
        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        genreLabel.font = .boldSystemFont(ofSize: 20)
        makeImageView(outerView: outerView, innerView: innerView)
        
        [
            titleLabel,
            originalTitleLabel,
            overviewLabel
        ]
            .forEach { $0.textColor = .black }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        originalTitleLabel.text = ""
    }
    
    
    func configurateCell() {
        guard let media else { return }
        
        if let date = media.releaseDate {
            dateLabel.text = date
        } else if let date = media.firstAirDate {
            dateLabel.text = date
        } else {
            dateLabel.text = "개봉일을 찾을 수 없습니다."
        }
        
        guard let genre else { return }
        genreLabel.text = "#" + (genre.first ?? "Romance")
        
        overviewLabel.text = media.overview
        
        guard let path = media.backdropPath else { return }
        let backdropURL = URL.makeImageURL(imagePath: path)
        backdropImageView.kf.setImage(with: backdropURL)
        
        if let title = media.title {
            titleLabel.text = title
        } else if let title = media.originalTitle {
            originalTitleLabel.text = title
        } else if let title = media.originalName {
            originalTitleLabel.text = title
        } else {
            titleLabel.text = "타이틀을 가져올 수 없습니다."
        }
    }
    
    
}

