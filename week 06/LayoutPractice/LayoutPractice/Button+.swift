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
