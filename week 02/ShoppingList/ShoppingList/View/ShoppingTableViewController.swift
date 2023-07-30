//
//  ShoppingTableViewController.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var list = Shopping().list
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var somethingToBuy: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designHeader()
        
    }

    
    @IBAction func editingTextField(_ sender: UITextField) {
        
        guard let text = sender.text else {
            return
        }
        
        somethingToBuy = text
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if somethingToBuy.isEmpty {
            giveAlert(title: "추가할 물건을 적어 주세요!", message: "")
            return
        }
    
        list.append(Stuff(name: somethingToBuy, liked: false, checked: false))
        somethingToBuy = ""
        tableView.reloadData()
        
    }
    
    
    
    // cell 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // section Number
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // cell design
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingTableViewCell") as! ShoppingTableViewCell
        
        let row = indexPath.row
        
        cell.listLabel.text = list[row].name
        
        if list[row].checked {
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if list[row].liked {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    func designHeader() {
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        addButton.tintColor = .black
        addButton.backgroundColor = .systemGray5
    }
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
    
}
