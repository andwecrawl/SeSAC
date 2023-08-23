//
//  View+.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/21.
//

import UIKit

class RadiusView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UIView {
    static func filterBuilder(color: UIColor, opacity: Float) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.opacity = opacity
        return view
    }
    
    static func makeImageView(outerView: UIView, innerView: UIView) {
        // 그림자랑 cornerRadius 수정
        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowOpacity = 0.3
    }
}

extension UIImageView {
    static func imageBuilder(image: String, cornerRadius: CGFloat) -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: image)
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        return view
    }
}

extension UIStackView {
    static func stackViewBuilder(space: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.spacing = space
        return stackView
    }
}
