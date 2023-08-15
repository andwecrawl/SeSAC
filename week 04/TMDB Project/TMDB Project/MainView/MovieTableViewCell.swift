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
    @IBOutlet weak var actorLabel: UILabel!
    
    var media: TrendMedia?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        genreLabel.font = .boldSystemFont(ofSize: 20)
        backdropImageView.image = UIImage(named: "testImage")
        makeImageView(outerView: outerView, innerView: innerView)
        
        
    }
    
    func configurateCell() {
        guard let media else { return }
        dateLabel.text = media.date
        genreLabel.text = media.genre
        
        let backdropURL = URL.makeImageURL(imagePath: media.backdropImage)
        backdropImageView.kf.setImage(with: backdropURL)
        titleLabel.text = media.title
        
        
        
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
