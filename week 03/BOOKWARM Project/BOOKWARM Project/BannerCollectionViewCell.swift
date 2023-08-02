//
//  BannerCollectionViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/02.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
   
    var movie: Movie?
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    func configurateBanner() {
        
        guard let movie else { return }
        
        bannerImageView.image = UIImage(named: movie.name + "b")
        bannerImageView.layer.cornerRadius = 5
    }
}
