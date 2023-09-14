//
//  DetailViewController.swift
//  firstApp
//
//  Created by yeoni on 2023/07/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var loginTextFieldCollection: [UITextField]!
    @IBOutlet var enterButton: UIButton!
    
    @IBOutlet weak var informationSwitch: UISwitch!
    
    let placeholderText: [String] = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "추천 코드 입력"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.setTitle("회원가입", for: .normal)
        enterButton.setTitleColor(UIColor.white, for: .normal)
        enterButton.layer.cornerRadius = 10
        
        for index in placeholderText.indices {
            let textField = loginTextFieldCollection[index]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText[index], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textField.textAlignment = .center
            textField.borderStyle = .roundedRect
            
            
            switch textField.placeholder {
            case "비밀번호":
                textField.textContentType = .password
                textField.isSecureTextEntry = true
            case "닉네임":
                textField.textContentType = .nickname
            case "추천코드":
                textField.keyboardType = .numberPad
                // textField.textContentType = .nu
            default:
                textField.textContentType = .emailAddress
            }
            if textField.placeholder == "비밀번호" {
                textField.textContentType = .password
                textField.isSecureTextEntry = true
            } else if textField.placeholder == "추천코드" {
                textField.keyboardType = .numberPad
            }
            
            informationSwitch.onTintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            informationSwitch.thumbTintColor = .white
            informationSwitch.setOn(true, animated: false)
        }
    }
    
    // 추천 코드
    @IBAction func codeEditingTextField(_ sender: UITextField) {
        if let str = sender.text {
            for i in str.reversed() {
                if i.isNumber {
                    return
                }
            }
        }
    }
    
    
    @IBAction func enterButtonTapped(_ sender: UIButton) {
        
        var errorCheck = false
        
        if loginTextFieldCollection[1].text?.count ?? 0 < 6 {
            requestAlert(title: "비밀번호를 6자 이상 입력해 주세요!", message: "특수문자, 영어, 숫자를 포함하면 더욱 좋습니다.")
            errorCheck = true
        }
        if ((loginTextFieldCollection[0].text?.count ?? 0) > 6) && (( loginTextFieldCollection[0].text?.contains("@") ?? false) == false)  {
            requestAlert(title: "이메일을 입력해 주세요!", message: "example: abcde123@gmail.com")
            errorCheck = true
        }
        if !errorCheck {
            requestAlert(title: "환영합니다!", message: "HEEFLIX에서 다양한 컨텐츠를 즐겨 보세요.")
        }
        
    }
    
    @IBAction func tabGestureTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @IBAction func informationSwitch(_ sender: UISwitch) {
        
        /*
         switch가 활성화되면 추가 정보를 포함한 네 칸이 나타나고,
         switch가 활성화되지 않으면 추가 정보(닉네임, 초대번호)가 안 띄워졌으면 좋겠음
         추가적으로 활성화되지 않았을 떼 추가 정보들이 띄워지지 않는 만큼 올리고 싶은데... ㅠ,ㅠ
         이건 아마 애니메이션으로 만들 수 있지 않을까
        */
    }
    
    
    
    func requestAlert(title: String, message: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
        
        let accpet = UIAlertAction(title: "okay", style: .default)
        
        alert.addAction(accpet)
        
        present(alert, animated: true)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
