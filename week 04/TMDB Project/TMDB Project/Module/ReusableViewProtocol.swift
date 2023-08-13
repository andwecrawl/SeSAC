//
//  ReusableViewProtocol.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//extension 

extension MovieTableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension OverviewTableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CastTableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
