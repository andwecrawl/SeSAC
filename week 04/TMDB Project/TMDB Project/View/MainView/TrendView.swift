//
//  TrendView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
   
    let segmentedControl = {
        let trendsList = ["All", "Movie", "Tv", "Person"]
        var segment = UISegmentedControl(items: trendsList)
        segment.backgroundColor = .systemGray6
        segment.tintColor = .white
        return segment
    }()
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        view.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        super.configureView()
        addSubview(segmentedControl)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
