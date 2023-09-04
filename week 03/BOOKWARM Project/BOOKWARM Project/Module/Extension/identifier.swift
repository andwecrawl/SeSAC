//
//  identifier.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/04.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UITableViewCell {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
