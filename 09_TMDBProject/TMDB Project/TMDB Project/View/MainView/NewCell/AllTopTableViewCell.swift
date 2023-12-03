//
//  AllTopTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/12/02.
//

import UIKit
import Kingfisher

class AllTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todaysLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var media: Result?
    var genre: [String]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        guard let media else { return }
        guard let poster = media.posterPath else { return }
        guard let genre else { return }
        
        
        todaysLabel.text = "🔥 오늘의 " + media.mediaType.media
        
        if let title = media.title {
            titleLabel.text = title
        } else if let title = media.originalTitle {
            titleLabel.text = title
        } else if let title = media.originalName {
            titleLabel.text = title
        } else if let title = media.name {
            titleLabel.text = title
        } else {
            titleLabel.text = "타이틀을 불러올 수 없습니다."
        }
        
        if let overview = media.overview {
            overviewLabel.text = overview
        } else {
            overviewLabel.text = "줄거리를 불러올 수 없습니다."
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
        
        let descriptions = genreStr
        descriptionLabel.text = descriptions
        
        let url = URL.makeImageURL(imagePath: poster)
        posterImageView.kf.setImage(with: url)
    }
    
}
