//
//  TodoTableViewController.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

class TodoTableViewController: UITableViewController {

    let studyList = ["userDefault", "Enum", "class", "struct", "property", "IBAction", "IBOutlet"]
    let appleList = ["아이폰", "아이패드", "애플워치", "에어팟"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /*
    // section을 여러 개 쓰고 싶을 때!
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 나 section 2개 쓸 거야!
        return 2
    }
     */
    
    
    // 100%의 경우의 수를 return 해주어야 한다!
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return section == 0 ? "할 일이에용" : "가진 애플 제품이에용"
        
        if section == 0 {
            return "첫번째"
        } else if section == 1 {
            return "두번째"
        } else if section == 2 {
            return "세번째"
        } else {
            return ""
        }
    }
    
    // 1. 셀 갯수 (필수!!!)
    // 없으면 빌드했을 때 안 보이거나 할 수 있음
    // numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션 하나당 셀의 갯수
        return section == 0 ? studyList.count : 3
    }
    
    // cell을 design & data를 처리하는 함수 (필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // identifier에 맞는 셀이 없을 수 있기 때문에 옵셔널로 변환해 줌
        // -> 해제가 필요함!
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        
        cell.textLabel?.text = "\(indexPath) 위치에 있는 셀입니다."
        
        
        if indexPath.section == 0 {
            cell.textLabel?.text = studyList[indexPath.row]
        } else {
            cell.textLabel?.text = appleList[indexPath.row]
        }
        
        
            // cell.textLabel?.text = studyList[indexPath.row]
        
        cell.textLabel?.font = .systemFont(ofSize: 17)
        
        return cell
    }
    
    /*
    완벽하게 필수는 X
    // 3. cell의 높이
 
     // 서비스 구현에 따라 필요한 경우가 많지만, 항상 같은 높이를 셀에서 사용한다면 비효율적일 수 있음
     왜냠 셀이 로딩될 때마다 계속 함수가 시행되어야 하기 때문이다.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 섹션과 셀 중 셀을 기준으로 나누기!
            return 50
    }
     */
}
