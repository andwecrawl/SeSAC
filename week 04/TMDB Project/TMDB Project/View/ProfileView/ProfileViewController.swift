//
//  ProfileViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    let mainView = ProfileView()
    
    let settingList = SettingList().user
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configureView() {
        super.configureView()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        title = "Profile"
        
        mainView.imageButton.addTarget(self, action: #selector(profileClicked), for: .touchUpInside)
        mainView.profileButton.addTarget(self, action: #selector(profileClicked), for: .touchUpInside)
    }
    
    @objc func profileClicked() {
        
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell()}
        let element = settingList[indexPath.row].name.rawValue
        cell.settingLabel.text = element
        cell.textField.placeholder = element
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditingViewController()
        vc.setting = settingList[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
