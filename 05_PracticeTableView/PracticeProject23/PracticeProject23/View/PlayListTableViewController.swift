//
//  PlayListTableViewController.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

class PlayListTableViewController: UITableViewController {
    
    var list = ["장보기", "영화보기", "잠자기", "코드보기", "노래 듣기", "집 가기", "쇼핑하기"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIView 상속받고 있어서 쓸 수 있음
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
       
       giveAlert(title: "추가", message: "냠냠")
        // 1. list에 내용 추가
        list.append("냠냠")
        print(list)
        
        // data가 달라졌으니 tableView를 다시 어쩌구해주세용
        // 동기화 작업!!
        // 뷰와 데이터는 따로 놀기 땜에 적절하게 맞춰줘야 함
        tableView.reloadData()
    }
    
    
    
    
    
    /*
     테이블뷰 필수 메서드
     1. 셀 갯수
     테이블 뷰가 몇 개의 셀로 구성되어 있는지 알려주는 것이 아니라 몇 개의 셀을 생성해야 할지 iOS 시스템한테 준비해 달라고 이야기하는 것을 말함
     2. 셀 디자인 및 데이터 처리
     3. 셀 높이
     */
    
    // 1. 섹션 내 셀의 갯수: 카톡 친구 수만큼 셀 갯수가 필요해! 라고 iOS에 전달
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 2. 셀의 디자인 및 데이터 처리: 카톡 프로필 모서리 둥글게 같은 거
    //프로필 이미지와 상테 메세지 변경 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // system 기반으로 할 거라 for 없이!!
        // Identifier는 인터페이스 빌더에서 설정!
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        // 앱을 조금 더 효율적으로 쓸 수 있또록 재사용하자!!
        // 컨베이어 벨트에 동작하는 것처럼 틀을 계속 재활용
        // 데이터만 바꿔주는 과정!!
        // 보통 스크린에 보이는 셀만큼만 준비함
        // 그걸 보여주는 친구가 dequeueReusableCell
        // 이걸 재사용 매커니즘이라고 함
        
        cell.textLabel?.text = list[indexPath.row]
        
        
        //        cell.textLabel?.text = "텍스트"
        
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
        
        
        
        
        cell.textLabel?.configureTitleText()
        
        cell.detailTextLabel?.text = "디테일 텍스트"
        cell.detailTextLabel?.textColor = .blue
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    
    // 3. 셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
