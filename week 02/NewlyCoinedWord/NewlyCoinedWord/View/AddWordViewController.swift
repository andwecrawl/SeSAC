//
//  AddWordViewController.swift
//  NewlyCoinedWord
//
//  Created by yeoni on 2023/07/24.
//

import UIKit

class AddWordViewController: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var meaningTextView: UITextView!
    
    var newWord: String? = nil
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordTextField.layer.borderColor = UIColor.black.cgColor
        wordTextField.layer.borderWidth = 1
        meaningTextView.layer.borderColor = UIColor.black.cgColor
        meaningTextView.layer.borderWidth = 1
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func textingWordTextField(_ sender: UITextField) {
        newWord = sender.text
    }
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        // 분기 처리
        guard let word = newWord else {
            giveAlert(title: "새 신조어를 입력해 주세요!", message: "추가할 신조어가 입력되지 않았습니다.")
            return
        }
        if meaningTextView.text.count == 0 {
            giveAlert(title: "신조어의 뜻을 입력해 주세요!", message: "신조어의 뜻이 입력되지 않았습니다.")
            return
        }
        
        coinedWords[word.uppercased()] = meaningTextView.text!
        giveAlert(title: "단어가 추가되었습니다!", message: #"\#(String(describing: coinedWords[word.uppercased()]))라는 뜻의 신조어 \#(word)가 추가되었습니다."#)
        meaningTextView.text = nil
        wordTextField.text = nil
    }
    
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
    
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    


}
