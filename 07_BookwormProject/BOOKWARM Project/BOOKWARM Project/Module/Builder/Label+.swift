//
//  Builder.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import UIKit

extension UILabel {
    static func labelBuilder(size: CGFloat, weight: UIFont.Weight, color: UIColor = .black) -> UILabel {
        let view = UILabel()
        view.font = .systemFont(ofSize: size, weight: weight)
        view.textColor = color
        return view
    }
}

