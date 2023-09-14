//
//  CustomTableViewCell.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell" // 타입 프로퍼티
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    

    override func awakeFromNib() {
        mainTitleLabel.font = .boldSystemFont(ofSize: 17)
        mainTitleLabel.textColor = .brown
    }
    
   // 항상 data가 우선!!
    func configureCell(row: ToDo) {
        
        mainTitleLabel.font = .boldSystemFont(ofSize: 17)
        mainTitleLabel.textColor = .brown
        
        
        bgView.backgroundColor = row.color
        
        mainTitleLabel.text = row.main
        mainTitleLabel.textColor = .black
        subTitleLabel.text = row.sub
        subTitleLabel.textColor = .lightGray
        
        if row.done {
            checkboxImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            checkboxImageView.image = UIImage(systemName: "checkmark.square")
        }
        
        if row.like {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }

    }
    
    
    
}
