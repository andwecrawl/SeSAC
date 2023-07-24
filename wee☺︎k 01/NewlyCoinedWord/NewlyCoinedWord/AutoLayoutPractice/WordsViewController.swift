//
//  WordsViewController.swift
//  NewlyCoinedWord
//
//  Created by yeoni on 2023/07/21.
//

import UIKit

class WordsViewController: UIViewController {

    
    @IBOutlet weak var wordTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var firstWordButton: UIButton!
    @IBOutlet weak var secondWordButton: UIButton!
    @IBOutlet weak var thirdWordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordTextField.text = getRandomWord()
        
        let buttonBundle = [
            firstWordButton!,
            secondWordButton!,
            thirdWordButton!
        ]
        
        for button in buttonBundle {
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.titleLabel?.textColor = .black
        }
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.font = .systemFont(ofSize: 20)
    }
    
    // 반환값을 써도 되고 안 써도 되는 경우에 사용하는 keyword
    @discardableResult
    func getRandomWord() -> String {
        let random = ["바밤바", "김치볶음밥", "떡꼬치", "육회", "빈대떡"]
        return random.randomElement()!
    }
    
    @IBAction func textFieldKeyboardTapped(_ sender: UITextField) {
        print("tapped!")
        
//        if wordTextField.text == "별다줄" {
//            resultLabel.text = "별 거 다 줄인다는 뜻입니다."
//        } else if wordTextField.text == "알잘딱깔센" {
//            resultLabel.text = "알아서 잘 딱 깔끔하고 센스 있게"
//        } else {
//            resultLabel.text = "자연스러운 만남 추구"
//        }
       
        switch wordTextField.text?.lowercased() {
        case "별다줄":
            resultLabel.text = "별 거 다 줄인다는 뜻입니다."
        case "알잘딱깔센":
            resultLabel.text = "알아서 잘 딱 깔끔하고 센스 있게"
        case "자만추":
            resultLabel.text = "자연스러운 만남 추구"
         default:
            resultLabel.text = "찾는 결과가 없습니다."
         }
        // 얘를 더 효율적으로 만들 수는 없을까?
        
        // 현재 button 오류 발생이 많음....
        // plain -> default 바꾸거나
        // button configuration을 사용하면 좋지 않을까 ^, ^
        
        /*
        switch 판단 요소 {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
         */
        
    }
    
    // 버튼 클릭 시 텍스트 필드의 텍스트에 버튼 타이틀이 들어가는 기능
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        // currentTitle이 15 이상에서는 안 나올 수도 있음
        print(sender.currentTitle) // default로 설정되어 있을 때 ^_^
        print(sender.titleLabel?.text)
        
        wordTextField.text = sender.currentTitle
        textFieldKeyboardTapped(wordTextField)
        
        
        
    }
    
    
    
    

}
