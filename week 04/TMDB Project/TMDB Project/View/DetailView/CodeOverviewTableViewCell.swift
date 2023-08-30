//
//  OverviewTableViewCell.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/30.
//

import UIKit

class CodeOverviewTableViewCell: BaseTableViewCell {
    
    let overviewLabel = UILabel.labelBuilder(size: 14, weight: .medium)
    
    override func awakeFromNib() {
        overviewLabel.textAlignment = .justified
    }
    
    override func configureView() {
        addSubview(overviewLabel)
    }
    
    override func setConstraints() {
        overviewLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
