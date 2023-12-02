//
//  TabViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/11/19.
//

import UIKit
import SnapKit

class TabViewController: BaseViewController {
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.separatorColor = .darkGray
        let nib = UINib(nibName: newTrendCell.identifier, bundle: nil)
        view.register(nib, forCellReuseIdentifier: newTrendCell.identifier)
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        view.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        return view
    }()
    
    override func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
