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
        // Do any additional setup after loading the view.
        
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
        if let word = searchTextField.text?.uppercased() {
            if let result = coinedWords[word] {
                meansTextLabel.text = result
            } else {
                let alert = UIAlertController(title: "올바른 단어를 입력해 주세요!", message: "해당 단어가 존재하지 않습니다. 맞춤법을 확인해 주세요!", preferredStyle: .alert)
                let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
                alert.addAction(okay)
                present(alert, animated: true)
                // meansTextLabel.text = "올바른 단어를 입력해 주세요!"
            }
        } else {
            let alert = UIAlertController(title: "단어를 입력해 주세요!", message: "", preferredStyle: .alert)
            let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
            alert.addAction(okay)
            present(alert, animated: true)
            // meansTextLabel.text = "단어를 입력해 주세요!"
        }
        changeExampleWords()
    }
    
    
    
    @IBAction func searchTextField(_ sender: UITextField) {
        
        if let word = sender.text?.uppercased() {
            if let result = coinedWords[word] {
                meansTextLabel.text = result
            } else {
                meansTextLabel.text = "올바른 단어를 입력해 주세요!"
            }
        } else {
            meansTextLabel.text = "단어를 입력해 주세요!"
        }
        changeExampleWords()
    }
    
    
    
    func changeExampleWords() {
        let exampleWords: [String] = randomWords()
        
        
//        firstExampleWordButton.titleLabel?.text = exampleWords[0].lowercased()
//        secondExampleWordButton.titleLabel?.text = exampleWords[1].lowercased()
//        thirdExampleWordButton.titleLabel?.text = exampleWords[2].lowercased()
        /*
         왜 titleLabel?.text로 넣었을 때는 들어가는 값이 button으로 들어갈까?
         예상으로는 겉으로 들어가는 titleLabel.text 값만 바꿔줘서 그런  것 같음
         아래 setTitle은 각 상태에서 title 자체를 바꿔주는 거니까... 적용이 되는듯?
         */
        
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
    
    
    @IBAction func addNewWord(_ sender: UIBarButtonItem) {
        // 단어 추가
        
        // Dictionary에 add하는 거 만들고 하면 될 것 같음 ^_^
        
    }
    
    
    func designMeaningLabel() {
        meansTextLabel.textAlignment = .center
        meansTextLabel.numberOfLines = 0
    }
    
    
}

