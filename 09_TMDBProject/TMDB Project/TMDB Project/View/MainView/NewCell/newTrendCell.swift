//
//  newTrendCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit

class newTrendCell: UITableViewCell {
    
    @IBOutlet weak var RankLabel: UILabel!
    @IBOutlet weak var backdropImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var media: Result?
    var genre: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configurateCell() {
        guard let media else { return
            print("no media return")
        }
        guard let genre else { return
            print("no genre return")
        }
        
        var mediaDate = ""
        if let date = media.releaseDate {
            mediaDate += date
        } else if let date = media.firstAirDate {
            mediaDate += date
        } else {
            mediaDate = "개봉일을 찾을 수 없습니다."
        }
        
        let genreStr = genre.joined(separator: " · ")
        
        let descriptions = mediaDate + " | " + genreStr
        descriptionLabel.text = descriptions
        
        overviewLabel.text = media.overview
        
        guard let path = media.backdropPath else { return }
        let backdropURL = URL.makeImageURL(imagePath: path)
        backdropImageVIew.kf.setImage(with: backdropURL)
        backdropImageVIew.contentMode = .scaleToFill
        
        if let title = media.title {
            titleLabel.text = title
        } else if let title = media.originalTitle {
            titleLabel.text = title
        } else if let title = media.originalName {
            titleLabel.text = title
        } else {
            titleLabel.text = "타이틀을 가져올 수 없습니다."
        }
    }
}
