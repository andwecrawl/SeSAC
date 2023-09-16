//
//  ButtonBuilder.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit

extension UIButton {
    static func buttonBuilder(title: String) -> UIButton {
        let view = UIButton()
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.setTitle(title, for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemRed
        return view
    }
    
}
