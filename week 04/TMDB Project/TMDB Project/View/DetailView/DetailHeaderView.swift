//
//  DetailView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/30.
//

import UIKit
import SnapKit

class DetailHeaderView: UITableViewHeaderFooterView {
    static let headerViewID = "DetailHeaderView"
    
    let mainBackImageView = UIImageView.imageBuilder()
    let filterView = UIView.filterBuilder(color: .black)
    let titleLabel = UILabel.labelBuilder(size: 26, weight: .bold)
    let posterImageView = UIImageView.imageBuilder()
    
    let DetailTableView = {
        let view = UITableView(frame: .zero)
        view.register(CodeOverviewTableViewCell.self, forCellReuseIdentifier: CodeOverviewTableViewCell.identifier)
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        addSubview(mainBackImageView)
        addSubview(filterView)
        addSubview(titleLabel)
        addSubview(posterImageView)
        
        UILabel.addShadow(label: titleLabel)
    }
    
    func setConstraints() {
        mainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filterView.snp.makeConstraints { make in
            make.edges.equalTo(mainBackImageView)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalTo(16)
            make.bottom.equalToSuperview().inset(12)
            make.height.lessThanOrEqualTo(120)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.bottom.leading.equalTo(12)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
        }
        
    }
    
    
    
}
