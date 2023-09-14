//
//  ViewController.swift
//  NewlyCoinedWord
//
//  Created by yeoni on 2023/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var meansTextLabel: UILabel!
    
    @IBOutlet var exampleWordButton: [UIButton]!
    
    @IBOutlet weak var firstExampleWordButton: UIButton!
    @IBOutlet weak var secondExampleWordButton: UIButton!
    @IBOutlet weak var thirdExampleWordButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meansTextLabel.text = "신조어 검색기"
        meansTextLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        changeExampleWords()
        designButtons()
        designMeaningLabel()
    }
    
    
    
    @IBAction func exampleWordButtons(_ sender: UIButton) {
        searchTextField.text = sender.titleLabel?.text
        searchTextField.text = sender.currentTitle
    }
    
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        meansTextLabel.font = UIFont.systemFont(ofSize: 15)
        // guard let으로 변경해보는건어떨까
        
        guard let word = searchTextField.text?.uppercased() else {
            giveAlert(title: "단어를 입력해 주세요!", message: "")
            return
        }
        guard let result = coinedWords[word] else {
            giveAlert(title: "올바른 단어를 입력해 주세요!", message: "해당 단어가 존재하지 않습니다. 맞춤법을 확인해 주세요!")
            return
        }
        
        meansTextLabel.text = result
        changeExampleWords()
    }
    
    
    
    @IBAction func searchTextField(_ sender: UITextField) {
        
        guard let word = sender.text?.uppercased() else {
            giveAlert(title: "단어를 입력해 주세요!", message: "")
            return
        }
        guard let result = coinedWords[word] else {
            giveAlert(title: "올바른 단어를 입력해 주세요!", message: "해당 단어가 존재하지 않습니다. 맞춤법을 확인해 주세요!")
            return
        }
        
        if result.count < 2 {
            giveAlert(title: "올바른 단어를 입력해 주세요!", message: "글자수가 너무 짧습니다!")
        } else {
            meansTextLabel.text = result
        }
        changeExampleWords()
    }
    
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
        meansTextLabel.text = title
    }
    
    
    func changeExampleWords() {
        let exampleWords: [String] = randomWords()
        
        firstExampleWordButton.setTitle(exampleWords[0], for: .normal)
        secondExampleWordButton.setTitle(exampleWords[1], for: .normal)
        thirdExampleWordButton.setTitle(exampleWords[2], for: .normal)
    }
    
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    func designButtons() {
        let buttons = [firstExampleWordButton!, secondExampleWordButton!, thirdExampleWordButton!]
        
        for button in buttons {
            button.titleLabel?.textAlignment = .center
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.titleLabel?.textColor = .black
            button.tintColor = .black
            button.titleLabel?.numberOfLines = 1
            button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            
        }
    }
    
    
    func designMeaningLabel() {
        meansTextLabel.textAlignment = .center
        meansTextLabel.numberOfLines = 0
    }
    
    
}

