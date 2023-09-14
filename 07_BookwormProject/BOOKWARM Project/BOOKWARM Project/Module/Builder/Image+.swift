//
//  Image+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
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
