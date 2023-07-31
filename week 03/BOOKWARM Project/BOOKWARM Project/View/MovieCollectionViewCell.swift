//
//  MovieCollectionViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    let colors: [UIColor] = [
        .cyan,
        .green,
        .lightGray,
        .magenta,
        .purple,
        .systemBlue,
        .systemRed,
        .systemMint,
        .systemPink,
        .orange,
        .systemIndigo,
        .yellow,
        .brown,
        .systemTeal
    ]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    @IBOutlet weak var backView: UIView!
    
    
    func designCell() {
        guard let movie else {
            return
        }
        
        nameLabel.text = movie.name
        nameLabel.font = .boldSystemFont(ofSize: 18)
        posterImageView.image = UIImage(named: movie.name)
        rateLabel.font = .systemFont(ofSize: 13)
        rateLabel.text = String(movie.rate)
        backView.backgroundColor = colors.randomElement()!
    }
    
    
    
}
