//
//  Extension.swift
//  TVCPractice
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
