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
    
    
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        
        if checkboxButton.currentImage == UIImage(systemName: "checkmark.square") {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        // UIButton이 어떤 IndexPath를 받는지 알고 그 값을 바꿔주고 싶은데 어떻게 해야 할지 모르겠음
        
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        
        if starButton.currentImage == UIImage(systemName: "star") {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        // 이친구도...
        // configurateCell
    }
    
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
