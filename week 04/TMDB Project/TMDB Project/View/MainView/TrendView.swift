//
//  TrendView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
