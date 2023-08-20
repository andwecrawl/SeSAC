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
    
    var posterPath: String?
    
    // bgView와 posterImageView에 모두 posterImage를 넣음 댐~~
    // 아님 bgview에 정말 backdropPath를 넣어도 되고~~!!
    
    
    func configureCell() {
        guard let posterPath else {
            bgImageView.backgroundColor = .gray
            posterImageView.image = UIImage(named: "noImage")
            return
        }
        
        
        let url = URL.makeImageURL(imagePath: posterPath)
        bgImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
    }

}
