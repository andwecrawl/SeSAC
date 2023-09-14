//
//  Label+.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/23.
//

import UIKit

extension PaddingLabel {
    
    static func labelBuilder(text: String, size: CGFloat, isChat: Bool) -> UILabel {
        let label = PaddingLabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: size)
        label.textAlignment = .center
        if isChat {
            label.padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            label.textColor = .black
            label.backgroundColor = .white
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
        } else {
            label.textColor = .white
        }
        return label
    }
    
    
}

class PaddingLabel: UILabel {
    var padding: UIEdgeInsets
    
    @IBInspectable
    var left: CGFloat {
        get {
            self.padding.left
        }
        set {
            self.padding.left = newValue
        }
    }
    
    @IBInspectable
    var right: CGFloat {
        get {
            self.padding.right
        }
        set {
            self.padding.right = newValue
        }
    }
    
    @IBInspectable
    var top: CGFloat {
        get {
            self.padding.top
        }
        set {
            self.padding.top = newValue
        }
    }
    
    @IBInspectable
    var bottom: CGFloat {
        get {
            self.padding.bottom
        }
        set {
            self.padding.bottom = newValue
        }
    }
    
    override init(frame: CGRect) {
        self.padding = .zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.padding = .zero
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    convenience init(inset: UIEdgeInsets) {
        self.init(frame: .zero)
        self.padding = inset
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom
        return size
    }
}


