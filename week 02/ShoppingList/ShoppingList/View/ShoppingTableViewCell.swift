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
    
    /*
     UIImage(systemName: "checkmark.square")
     UIImage(systemName: "checkmark.square.fill")
     
     UIImage(systemName: "star")
     UIImage(systemName: "star.fill")
     */
    
    
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        
        if checkboxButton.currentImage == UIImage(systemName: "checkmark.square") {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        
        if starButton.currentImage == UIImage(systemName: "star") {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    func configurateCell() {
        
    }
    
    
    
    
}
