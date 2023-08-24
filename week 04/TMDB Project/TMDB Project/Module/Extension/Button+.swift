//
//  Button+.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/24.
//

import UIKit
import SnapKit

extension UIButton {
    static func buttonBuilder(bgColor: UIColor, image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = bgColor
        button.tintColor = .white
        button.layer.opacity = 0.8
        button.snp.makeConstraints { make in
            make.size.equalTo(60)
        }
        return button
    }
    
}
