//
//  ViewBuilder.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit
import SnapKit

extension UIView {
    static func viewBuilder(bgColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        view.snp.makeConstraints { make in
            make.height.equalTo(view.snp.width)
        }
        view.layer.cornerRadius =  20
        return view
    }
}
