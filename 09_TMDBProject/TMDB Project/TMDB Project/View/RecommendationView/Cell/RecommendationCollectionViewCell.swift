//
//  RecommendationCollectionViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import UIKit
import Kingfisher

class RecommendationCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Result?
    var posterPath: String?
    
    // bgView와 posterImageView에 모두 posterImage를 넣음 댐~~
    // 아님 bgview에 정말 backdropPath를 넣어도 되고~~!!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Color.background.color
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bgImageView.image = UIImage(named: "test")
        titleLabel.text = "타이틀이에용"
        descriptionLabel.text = "설명이에용"
    }
    
    func configureCell() {
        guard let movie else { return }
        guard let posterPath = movie.posterPath else {
            bgImageView.backgroundColor = .gray
            posterImageView.image = UIImage(named: "noImage")
            return
        }
        
        
        let url = URL.makeImageURL(imagePath: posterPath)
        bgImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
        
        if let title = movie.title {
            titleLabel.text = title
        } else if let title = movie.originalTitle {
            titleLabel.text = title
        } else if let title = movie.originalName {
            titleLabel.text = title
        }
        
        descriptionLabel.text = movie.descriptions
    }

}
