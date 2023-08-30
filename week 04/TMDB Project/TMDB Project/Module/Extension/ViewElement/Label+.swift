//
//  Label+.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/17.
//

import UIKit

extension UILabel {
    static func addShadow(label: UILabel) {
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 2
        label.layer.shadowColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
    }
}
