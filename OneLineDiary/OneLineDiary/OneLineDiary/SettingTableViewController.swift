//
//  SettingTableViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/08/01.
//

import UIKit


enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    
    var mainOptions: String {
        get {
            switch self {
            case .total:
                return "전체 설정"
            case .personal:
                return "개인 설정"
            case .others:
                return "기타"
            }
        }
    }
    
    var subOptions: [String] {
        switch self {
        case .total:
            return  ["가나다라", "마바사아", "아자차카", "타파하"]
        case .personal:
            return ["가나다라", "마바사아", "아자차카", "타파하"]
        case .others:
            return ["가나다라", "마바사아", "아자차카", "타파하"]
        }
    }
}





class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SettingOptions.allCases[section].subOptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell")!
            
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        cell.textLabel?.textColor = .black
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOptions
    }
    
}
