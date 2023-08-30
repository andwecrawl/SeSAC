//
//  FilterBuilder.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/31.
//

import UIKit

extension UIView {
    static func filterBuilder(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.opacity = 0.3
        return view
    }
}
