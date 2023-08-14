//
//  OverviewTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/14.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overviewTextView.isEditable = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
