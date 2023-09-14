//
//  Button+.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/21.
//

import UIKit

class radiusButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UIButton {
    static func buttonBuilder(image: UIImage?, title: String, cornerRadius: CGFloat) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        if title.isEmpty {
            button.layer.cornerRadius = cornerRadius
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
        } else {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .top
            button.backgroundColor = .clear
            configuration.imagePadding = 15
            var attributedTitle = AttributedString(title)
            attributedTitle.font = .preferredFont(forTextStyle: .caption2)
            configuration.attributedTitle = attributedTitle
            button.configuration = configuration
        }
        button.tintColor = .white
        return button
    }
}
