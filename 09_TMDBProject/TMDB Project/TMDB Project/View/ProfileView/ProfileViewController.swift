//
//  ProfileViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit
import PhotosUI

class ProfileViewController: BaseViewController {
    let mainView = ProfileView()
    
    var settingList = SettingList().user
    
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
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}


extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        // itemProvider == 선택한 asset을 보여주는 역할을 함!!
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            let type: NSItemProviderReading.Type = UIImage.self
            itemProvider.loadObject(ofClass: type) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.mainView.profileImageView.image = image
                        
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell()}
        let settings = settingList[indexPath.row].name.rawValue
        let data = settingList[indexPath.row].user
        cell.settingLabel.text = settings
        cell.textField.text = data
        cell.textField.placeholder = settings
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settingList[indexPath.row].name
        if setting == .Gender {
            let vc = PickerViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let vc = EditingViewController()
            vc.setting = setting
            vc.completionHandler = { text in
                self.settingList[indexPath.row].user = text
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

extension ProfileViewController: PassTextDelegate {
    func receiveText(text: String) {
        for index in settingList.indices {
            let setting = settingList[index]
            if setting.name == .Gender {
                settingList[index].user = text
                mainView.tableView.reloadData()
                return
            }
        }
    }
}
