//
//  MovieTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var media: Result?
    var genre: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = ""
        originalTitleLabel.text = ""
        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        genreLabel.font = .boldSystemFont(ofSize: 20)
        makeImageView(outerView: outerView, innerView: innerView)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        originalTitleLabel.text = ""
    }
    
    func configurateCell() {
        guard let media else { return }
        
        if let date = media.releaseDate {
            dateLabel.text = date
        } else if let date = media.firstAirDate {
            dateLabel.text = date
        } else {
            dateLabel.text = "개봉일을 찾을 수 없습니다."
        }

        guard let genre else { return }
        genreLabel.text = "#" + genre
        
        overviewLabel.text = media.overview
        
        guard let path = media.backdropPath else { return }
        let backdropURL = URL.makeImageURL(imagePath: path)
        backdropImageView.kf.setImage(with: backdropURL)
        
        if let title = media.title {
            titleLabel.text = title
        } else if let title = media.originalTitle {
            originalTitleLabel.text = title
        } else if let title = media.originalName {
            originalTitleLabel.text = title
        } else {
            titleLabel.text = "타이틀을 가져올 수 없습니다."
        }
    }
    
    
}
extension MovieTableViewCell {
    func makeImageView(outerView: UIView, innerView: UIView) {
        // 그림자랑 cornerRadius 수정
        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowOpacity = 0.3
    }
}
