//
//  TextFieldBuilder.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit

extension UITextField {
    static func textFieldBuilder(placeholder: String) -> UITextField {
        let view = UITextField()
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.textColor = .white
        view.textAlignment = .center
        return view
    }
}

