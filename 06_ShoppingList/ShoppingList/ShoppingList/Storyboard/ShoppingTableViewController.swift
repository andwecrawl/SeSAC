//
//  ShoppingTableViewController.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingTableViewController: UITableViewController {
    
    var shopping = Shopping() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var data = Shopping()
    
    lazy var list = BehaviorSubject(value: data.list)
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var somethingToBuy: String = ""
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designHeader()
    }
    

    
    @IBAction func textingTextField(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        
        somethingToBuy = text
    }
    
    @IBAction func returnTextField(_ sender: UITextField) {
        
        guard let text = sender.text else {
            return
        }
        
        somethingToBuy = text
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if somethingToBuy.isEmpty {
            sendOneSideAlert(title: "추가할 물건을 적어 주세요!", message: "")
            return
        }
        
        // 이미 같은 물건이 list 안에 있을 때 alert 기능
        if shopping.containedList(str: somethingToBuy) {
            sendOneSideAlert(title: "이미 리스트에 존재하는 물품입니다!", message: "")
            return
        }
    
        let thing = Stuff(name: somethingToBuy, liked: false, checked: false)
        shopping.list.insert(thing, at: 0)
        inputTextField.text = ""
        somethingToBuy = ""
        
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        shopping.list[sender.tag].liked.toggle()
    }
    
    @objc func checkboxButtonTapped(_ sender: UIButton) {
        shopping.list[sender.tag].checked.toggle()
    }
    
    func designHeader() {
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        addButton.tintColor = .black
        addButton.backgroundColor = .systemGray5
        
        self.tableView.rowHeight = 55
    }
    
    func sendOneSideAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
    
}


extension ShoppingTableViewController {
    
    // cell 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopping.list.count
    }
    
    // cell design
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingTableViewCell") as! ShoppingTableViewCell
        
        let row = shopping.list[indexPath.row] // Stuff
        
        cell.stuff = row
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        shopping.list.remove(at: indexPath.row)
    }
    
    
}
