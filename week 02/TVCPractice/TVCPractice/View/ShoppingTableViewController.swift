//
//  ShoppingTableViewController.swift
//  TVCPractice
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var listTextField: UITextField!
    
    var shoppingList = ["그립톡", "사이다", "아이패드 케이스", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designHeader()
    }
    
    
    @IBAction func editingTextField(_ sender: UITextField) {
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func addCell(_ sender: UIButton) {
        guard let text = listTextField.text else {
            giveAlert(title: "추가할 메세지를 입력해 주세요!", message: "")
            return
        }
        if text.count == 0 {
            giveAlert(title: "추가할 메세지를 입력해 주세요!", message: "")
            return
        }
        if shoppingList.contains(text) {
            giveAlert(title: "이미 쇼핑 리스트에 있는 물건입니다!", message: "")
            return
        }
        
        shoppingList.append(text)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell")!
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 8
        
        if indexPath.section == 0 {
            cell.textLabel?.text = shoppingList[indexPath.row]
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section == 0 ? "ShoppingList" : "AlreadyBought"
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func designHeader() {
        headerView.backgroundColor = .systemGray6
        headerView.layer.cornerRadius = 8
        
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemGray5
        addButton.tintColor = .black
        
        listTextField.placeholder = "무엇을 구매하실 건가요?"
        listTextField.setPlaceholder(color: .systemGray2)
        
    }
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}
