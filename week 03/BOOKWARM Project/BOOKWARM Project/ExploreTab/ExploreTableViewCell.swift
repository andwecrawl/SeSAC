//
//  ExploreTableViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/02.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    var movie: Movie?

    @IBOutlet weak var exploreImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    func configurateCell() {
        
        guard let movie else { return }
        
        exploreImageView.image = UIImage(named: movie.name)
        titleLabel.text = movie.name
        descriptionLabel.text = movie.exploreDescription
        rateLabel.text = "★" + String(movie.rate)
        
    }
}
