//
//  CastingTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit
import Kingfisher

class CastingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        nameLabel.text = "정보를 찾을 수 없습니다."
        characterLabel.text = "정보를 찾을 수 없습니다."
        profileImageView.image =  UIImage(named: "noImage")
    }
    
    var actors: CastElement? {
        didSet {
            guard let actors else { return }
            
            characterLabel.text = actors.character
            nameLabel.text = actors.originalName
            
            guard let profilePath = actors.profilePath else {
                profileImageView.image = UIImage(named: "noImage")
                return
            }
            let url = URL.makeImageURL(imagePath: profilePath)
            profileImageView.kf.setImage(with: url)
        }
    }
    
    
}
