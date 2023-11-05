//
//  HeaderView.swift
//  ShoppingList
//
//  Created by yeoni on 2023/11/05.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    let inputTextField = {
        let textField = UITextField()
        textField.placeholder = "무엇을 구매하실 건가요?"
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    let addButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.backgroundColor = .systemGray5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGray6
        
        [inputTextField, addButton]
            .forEach({ self.addSubview($0) })
        
        inputTextField.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        inputTextField.borderStyle = .roundedRect
        
        addButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(inputTextField.snp.trailing).offset(8)
            make.width.equalTo(54)
        }
        
        addButton.setTitle("추가", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
