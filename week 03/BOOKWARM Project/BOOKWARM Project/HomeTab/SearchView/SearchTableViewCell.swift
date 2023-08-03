//
//  SearchTableViewCell.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/08/03.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var movie: Movie?
    
    func configurateCell() {
        guard let movie else { return }
        
        let image = UIImage(named: movie.name)
        searchImageView.image = image
        titleLabel.text = movie.name
        descriptionLabel.text = movie.description
    }
    
}
