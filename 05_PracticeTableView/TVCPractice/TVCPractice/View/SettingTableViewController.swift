//
//  SettingTableViewController.swift
//  TVCPractice
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

class SettingTableViewController: UITableViewController {

    let header = ["전체 설정", "개인 설정", "기타"]
    let totalSetting = ["공지사항", "실험실", "버전 정보"]
    let personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let guitar = ["고객센터/도움말"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 1. 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        default:
            return 1
        }
    }
    
    
    // 2. 셀의 디자인 / 데이터를 처리하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = totalSetting[indexPath.row]
        case 1:
            cell.textLabel?.text = personalSetting[indexPath.row]
        default:
            cell.textLabel?.text = guitar[indexPath.row]
        }
        cell.textLabel?.font = .systemFont(ofSize: 18)
        
        return cell
    }
    
    
    // 3. 셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
   
    // 섹션의 헤더를 설정하는 것두 필요
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for index in header.indices {
            if section == index {
                return header[index]
            }
        }
        return ""
    }
    
    
    

}
