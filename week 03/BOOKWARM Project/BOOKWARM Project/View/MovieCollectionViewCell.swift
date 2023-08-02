//
//  MovieCollectionViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var likedButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    func designCell() {
        nameLabel.font = .boldSystemFont(ofSize: 13)
        rateLabel.font = .systemFont(ofSize: 10)
    }
    
    func fillCell() {
        guard let movie else {
            return
        }
        
        nameLabel.text = movie.name
        posterImageView.image = UIImage(named: movie.name)
        rateLabel.text = movie.description
        likedButton.tintColor = .gray
        backView.backgroundColor = movie.color
        
        if movie.liked {
            let likedImage = UIImage(systemName: "heart.fill")
            likedButton.setImage(likedImage, for: .normal)
            likedButton.tintColor = .systemRed
        } else {
            let unlikedImage = UIImage(systemName: "heart")
            likedButton.setImage(unlikedImage, for: .normal)
        }
    }
    
    
    
}
