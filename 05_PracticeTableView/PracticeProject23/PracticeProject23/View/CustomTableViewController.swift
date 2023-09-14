//
//  CustomTableViewController.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/28.
//

import UIKit


/*
 1. 파티를 막자.
 2. sender.tag로 해결될 수 없는 UI들...
 */


class CustomTableViewController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    // searchBar 안에 textfield가 구현되어 있음
    
    
    var todo = TodoInformation() {
        didSet {
            // 변수가 달라지는 걸 감지함!!
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight  = 80
        
        searchBar.placeholder = "할 일을 입력해 보세용!!"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
        

    }

    @objc func searchBarReturnTapped() {
        // :3c
        
        // Todo 항목 추가
        // 추가가 됐다 => data 변경!!
        // tableView 갱신!!
        guard let text = searchBar.text else { return }
        let date = Date().formatted(date: .complete, time: .omitted).description
        let data = ToDo(main: text, sub: date, like: false, done: false, color: TodoInformation.randomBackgroundColor())
        searchBar.text = ""
        todo.list.insert(data, at: 0)
    }
    

    
    // 1.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    // 2. 셀 디자인
    // 각 셀마다 실행이 댐
    // 눈에 보이는 셀의 갯수만큼 실행댐
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // storyboard 영역 -> code 영역 매칭해 준다고 보면 댐
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        
        let row = todo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        // 인터페이스 빌드에서 IBAction 연결 시 모두 클릭되는 문제가 생길 수 있어
        // 코드로 태그 구현!!
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        // data를 변경하고 갱신!!
        
        todo.list[sender.tag].like.toggle()
        
    }
    
    
    // 3. 셀 선택!!!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.data = todo.list[indexPath.row]
        
        present(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
    // swap 구현 => Cell을 수정 가능한 상태로 만든다와 같음
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 제거 -> 갱신
        todo.list.remove(at: indexPath.row)
        
    }
    
}
