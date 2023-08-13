//
//  MovieTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
   
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        genreLabel.font = .boldSystemFont(ofSize: 20)
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        posterImageView.image = UIImage(named: "testImage")
        makeImageView(outerView: posterImageView, innerView: outerView)

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func makeImageView(outerView: UIView, innerView: UIView) {
        // 그림자랑 cornerRadius 수정
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowOpacity = 0.9

        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
    }
    
}
