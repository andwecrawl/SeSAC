//
//  LabelBuilder.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit

extension UILabel {
    static func labelBuilder(text: String, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let view = UILabel()
        view.text = text
        view.font = .systemFont(ofSize: size, weight: weight)
        view.backgroundColor = .clear
        return view
    }
}
