//
//  ProfileView.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let headerView = {
        let view = UIView()
        return view
    }()
    
    var profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
    let imageButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let profileButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("사진 변경하기")
        attributedTitle.font = .preferredFont(forTextStyle: .caption1)
        config.attributedTitle = attributedTitle
        button.configuration = config
        return button
    }()
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return view
    }()
    
    
    override func configureView() {
        addSubview(headerView)
        headerView.addSubview(profileImageView)
        headerView.addSubview(imageButton)
        headerView.addSubview(profileButton)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(180)
        }
        
        profileImageView.layer.cornerRadius = 60
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4)
            make.size.equalTo(120)
        }
        
        imageButton.layer.cornerRadius = 60
        imageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView)
            make.size.equalTo(profileImageView)
        }
       
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
