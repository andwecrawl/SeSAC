//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit
import SnapKit
import RxSwift

class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier: String = "ShoppingTableViewCell"
    
    let checkboxButton = {
        let view = UIButton()
        return view
    }()
    
    let listLabel = {
        let label = UILabel()
        return label
    }()
    
    let starButton = {
        let button = UIButton()
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [checkboxButton, listLabel, starButton]
            .forEach({ self.addSubview($0) })
        
        checkboxButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(checkboxButton.snp.width)
        }
        
        starButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(starButton.snp.width)
        }
        
        listLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(starButton)
            make.leading.equalTo(checkboxButton.snp.trailing).offset(4)
            make.trailing.equalTo(starButton.snp.leading).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var stuff: Stuff?
    
    let disposeBag = DisposeBag()
    
    func configurateCell() {
        guard let stuff else { return }
        print(stuff)
        
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
