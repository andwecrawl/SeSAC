//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

// 내가 어떤 인터페이스빌더 타입에 존재하고 있는지 알고 있음
// 같은 스토리보드 파일에 있다고 하면 스토리보드 파일을 찾는 걸 생략할 수도? 있음 ㅋㅋ
class DiaryTableViewController: UITableViewController {

    var list = ["test1test1test1test1test1test1test1test1test1test1test1test1test1test1", "test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2", "test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // XIB 파일 만들고 수동으로 연결해 줄 때 사용하는 구문
        // XIB로 테이블뷰셀을 생성할 경우, 테이블뷰에 사용할 셀을 등록해 주는 과정이 필요함!!
        // XIB 파일로 만들면 어떤 뷰 컨트롤러에서든지 이렇게 불러서 사용할 수 있음!!
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
        // 자동으로 높이 설정해 보께!!
        /*
         Dynamic Height
         1. automaticDimension
         2. Label numberOfLines
         3. autoLayout(여백)
         */
        
        tableView.rowHeight = UITableView.automaticDimension
        // text의 양에 따라서 높이가 달라짐...
        
        
        // tableViewController의 경우에는 tableView와 Cell에 모두 background!!
        // 처음에 그냥 clear로 시작해서 나머지가 다 보이게!!
        tableView.backgroundColor = .red
        
    }

    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController") as? SearchCollectionViewController else {
            return
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        
        // 뷰 컨트롤러를 가지고 오는 작업이 필요함
        // 뷰 컨트롤러가 어떤 스토리보드 파일에 들어 있는지를!! 알아야 함
        // 다른 스토리보드 파일의 VC로 연결할 수도 있으니까
        
         // 1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 명확한 게 좋다!! 하믄 일단 명시적으로 스토리보드 파일을 선언해 주는 것이 좋고
        // 아니면 내가 간단하게 코드를 개선해 보고 싶다!! 하면 프로퍼티 기반으로 아래 같은 스토리 보드 내에 있따면?
        // 처럼 구현할 수도 있음
        
         // 2. 스토리보드 파일 내 뷰컨트롤러 찾기
        guard let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {
            return
        }
        
        // 같은 스토리보드 내에 있다면? ^_^
        // 아래와 같이 할 수 있음
        /*
        guard let vc  = storyboard?.instantiateViewController(identifier: "AddViewController") ? as AddViewController else {
            return
        }
        */
        
        
        // 2-1. 네비게이션 컨트롤러가 있는 형태(제목바)로 present 하고 싶은 경우
        // nav를 사용한다면, present와 화면 전환 방식도 nav로 수정해 주어야 함!!
        let nav = UINavigationController(rootViewController: vc)
        
         // 3. 화면 전환 방식 설정 (option)
         // modal animation
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .fullScreen
        
        
        // 2-1 이후라면
        nav.modalPresentationStyle = .fullScreen
        
         // 4. 화면 띄우기
            // modal => present
        //present(vc, animated: true)
            // present는 아래서 위로 띄우는 거
        
        // 2-1 이후라면
        present(nav, animated: true)
        // navigationController를 imbed 하고 나면 그 친구를 활용해서 띄워줘야 함
        // 상수를 연결고리에 맞게 잘 쓰고 있는지 확인!!
        
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.text = list[indexPath.row]
        cell.contentLabel.numberOfLines = 0
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
    // 1. system Delete
    // 주어진 셀에 의해서 편집 가능한 상태로 쓰겠다!
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 편집 상태겠거니~ => true
        // 아님!! false
        // 하나의 테이블뷰 안에서 어떤 건 편집 가능하고 어떤 건 편집 불가능하도록 만드는 거임!!!
        return true
    }
    
    
    // 2. System Delete
    // delete style로 주로 쓰임
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        print(list)
        tableView.reloadData()
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 몇 개 나올지가 배열로 표시되어 있다고 보면 댐
        // 카톡에서 뭐 즐겨찾기 핀 버튼 이런 거
        
        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        <#code#>
    }
    */
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        // Pass Data 2. vc가 가지고 있는 프로퍼티에 데이터 추가
        //vc.contents = list[indexPath.row]
        // 값 전달 ㅅ ㅣ아웃렛을 활용할 수는 없음
        vc.type = .edit
        vc.contents = list[indexPath.row]
        
        present(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none)
        
        
        /*
        // DetailViewController(UIViewController) 생성 후 present!!
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        // DetailViewController()와 sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController 의 차이
        // defailViewController()의 경우에는 인터페이스빌더 없이 Swift 파일만 불러오게 되기 때문에 코드베이스로 코드를 짤 때, 저렇게만 불러와도 괜찮다.
        // 지금은 XIB와 인터페이스빌더, 스토리보드를 이용하여 만들기 때문에 길게 써야 한다!!
        
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        // present(vc, animated: true)
        
        
        // Pass Data 2. VC가 가지고 있는 프로퍼티에 데이터 추가
        // vc = 이후 뷰를 기리키는 거임
        vc.contents = "Diary VC에서 데이터 전달하면서 화면 전환!!"
        
        // vc.contents = list[indexPath.row]
        // vc.contentsLabel.text = list[indexPath.row]
        // 값 전달 시 아웃렛 활용 불가!! ㅠ_ㅠ
        
        
        // 인터페이스 빌더에서 네비게이션 컨트롤러가 임베드 되어 있어야만 Push가 동작합니다!!!
        navigationController?.pushViewController(vc, animated: true)
         */
    }
    
    
}
