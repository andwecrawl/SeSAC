//
//  CastTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
