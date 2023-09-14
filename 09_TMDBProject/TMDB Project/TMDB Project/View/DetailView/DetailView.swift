//
//  DetailView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/31.
//

import UIKit

class DetailView: BaseView {
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailHeaderView.headerViewID)
        view.register(CodeOverviewTableViewCell.self, forCellReuseIdentifier: CodeOverviewTableViewCell.identifier)
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
