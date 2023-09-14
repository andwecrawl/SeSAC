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
        view.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.systemGray5])
        view.textColor = .systemGray5
        return view
    }
}

