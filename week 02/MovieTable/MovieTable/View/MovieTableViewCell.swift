//
//  MovieTableViewCell.swift
//  MovieTable
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let indentifier = "movieTableViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    func configurateCell(row: Movie) {
        posterImageView.image = UIImage(named: row.title)
        titleLabel.text = row.title
        subtitleLabel.text = "\(row.releaseDate) | \(row.runtime) | \(row.rate)"
        overviewLabel.text = row.overview
    }
    
    
    
    
}
