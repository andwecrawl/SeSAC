//
//  SegmentControl+.swift
//  TMDB Project
//
//  Created by yeoni on 2023/09/03.
//

import UIKit

extension UISegmentedControl {
    static func removeBackgroundAndDivider(segment: UISegmentedControl) -> UISegmentedControl {
        let image = UIImage()
        segment.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segment.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segment.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segment.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        return segment
    }
}
