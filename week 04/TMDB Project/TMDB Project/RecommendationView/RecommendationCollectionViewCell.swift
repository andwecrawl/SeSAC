//
//  RecommendationCollectionViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/19.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    // bgView와 posterImageView에 모두 posterImage를 넣음 댐~~
    // 아님 bgview에 정말 backdropPath를 넣어도 되고~~!!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
