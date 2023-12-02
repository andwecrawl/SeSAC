//
//  LabelBuilder.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

extension UILabel {
    
    static func labelBuilder(size: CGFloat, weight: UIFont.Weight, color: UIColor = .white) -> UILabel {
        let view = UILabel()
        view.font = .systemFont(ofSize: size, weight: weight)
        view.textColor = color
        return view
    }
}
