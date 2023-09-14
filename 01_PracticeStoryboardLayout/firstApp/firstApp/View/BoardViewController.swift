//
//  BoardViewController.swift
//  firstApp
//
//  Created by yeoni on 2023/07/19.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var testLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in testLabel {
            item.textColor = .red
            item.font = .boldSystemFont(ofSize: 15)
        }
        
        designBoardTextField()
        designResultLabel()
        
    }
    
    
    @IBAction func pushButtonTapped(_ sender: UIButton) {
        resultLabel.text = inputTextField.text
        inputTextField.text = ""
    }
    
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        // 키보드 내리기
        view.endEditing(true)
    }
    
    
    
    func designResultLabel() {
        resultLabel.textAlignment = .center
        resultLabel.text = "hello"
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.textColor = .blue
        resultLabel.numberOfLines = 3
    }
    
    func designBoardTextField() {
        inputTextField.placeholder = "내용을 입력해 주세요!"
        inputTextField.textColor = .brown
        inputTextField.keyboardType = .emailAddress
        inputTextField.borderStyle = .line
    }
    
}
