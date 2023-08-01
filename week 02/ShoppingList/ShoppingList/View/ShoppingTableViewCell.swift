//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    
    func configurateCell(row: Stuff) {
        
        listLabel.text = row.name
        
        if row.checked {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if row.liked {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    
    
    
}
