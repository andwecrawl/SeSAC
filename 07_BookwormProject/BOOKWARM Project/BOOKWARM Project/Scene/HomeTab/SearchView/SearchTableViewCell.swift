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
    var document: Document?
    
    override func awakeFromNib() {
//        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.font = .systemFont(ofSize: 15)
    }
    
    func configurateCell() {
        if let movie = movie {
            let image = UIImage(named: movie.name)
            searchImageView.image = image
            titleLabel.text = movie.name
            descriptionLabel.text = movie.description
        } else if let book = document {
            if let thumb = URL(string: book.thumbnail!) {
                searchImageView.kf.setImage(with: thumb)
            } else {
                searchImageView.image = UIImage(named: "noImage")
            }
            titleLabel.text = book.title
            descriptionLabel.text = book.authorsDescriptions
        }
    }
    
}
