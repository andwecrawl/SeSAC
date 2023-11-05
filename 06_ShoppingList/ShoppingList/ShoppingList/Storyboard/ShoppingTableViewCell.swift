//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit
import RxSwift

class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier: String = "shoppingTableViewCell"
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    var stuff: Stuff?
    
    let disposeBag = DisposeBag()
    
    func configurateCell() {
        guard let stuff else { return }
        
        listLabel.text = stuff.name
        
        if stuff.checked {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if stuff.liked {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    
    
    
}
