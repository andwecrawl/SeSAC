//
//  ImageBuilder.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

extension UIImageView {
    
    static func imageBuilder(tintColor: UIColor = .black) -> UIImageView {
        let view = UIImageView()
        view.tintColor = tintColor
        view.contentMode = .scaleAspectFill
        return view
    }
}

