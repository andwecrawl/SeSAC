//
//  DetailViewController.swift
//  firstApp
//
//  Created by yeoni on 2023/07/19.
//

import UIKit

enum TextFieldType: Int {
    case email = 100
    case password = 200
    case nickname = 300
    case inviteCode = 400
}


class DetailViewController: UIViewController {
    
    @IBOutlet var loginTextFieldCollection: [UITextField]!
    @IBOutlet var enterButton: UIButton!
    
    @IBOutlet weak var informationSwitch: UISwitch!
    
    
    
    let placeholderText: [String] = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "추천 코드 입력"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testString = UserDefaults.standard.string(forKey: "test")
        let testInt = UserDefaults.standard.integer(forKey: "testInt")
        let testBool = UserDefaults.standard.bool(forKey: "testBool")
        
        print(testString, testInt, testBool)
        
        
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let inviteCode = UserDefaults.standard.string(forKey: "inviteCode")
        
        if let email, let password, let nickname, let inviteCode {
            loginTextFieldCollection[0].text = email
            loginTextFieldCollection[1].text = password
            loginTextFieldCollection[2].text = nickname
            loginTextFieldCollection[3].text = inviteCode
        }
        
        
        loginTextFieldCollection[0].tag = TextFieldType.email.rawValue
        loginTextFieldCollection[1].tag = TextFieldType.password.rawValue
        loginTextFieldCollection[2].tag = TextFieldType.nickname.rawValue
        loginTextFieldCollection[3].tag = TextFieldType.inviteCode.rawValue
        
        
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
    
    // 추천 코드 입력란
    @IBAction func codeEditingTextField(_ sender: UITextField) {
        if let str = sender.text {
            for i in str.reversed() {
                if !i.isNumber { sender.text?.removeLast()
                }
            }
        }
    }
    
    
    
    @IBAction func editingTextField(_ sender: UITextField) {
        
        if sender.text != nil {
            // 보기 싫고 그럴싸하게 바꾸고 싶어용 -> 가드루
        }
        
        guard let text = sender.text else {
            // 값이 nil일 때 어떻게 할래?!
            print("값이 없습니다.")
            return
        }
        
        guard let value = TextFieldType(rawValue: sender.tag) else {
            print("오류가 발생했습니다!")
            return
        }
        
        switch  value {
        case .email:
            print("이메일은 \(text)입니다.")
        case .password:
            print("비밀번호는 \(text)입니다.")
        case .nickname:
            print("닉네임은 \(text)입니다.")
        case .inviteCode:
            print("추천 코드는 \(text)입니다.")
        }
        print("키보드 리턴 클릭: \(text)")
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
        
        
        // userDefaults
        // 사물함 안에 Key값을 저장하고 그 안에 value값을 저장한다.
        UserDefaults.standard.set(loginTextFieldCollection[0].text!, forKey: "email")
        UserDefaults.standard.set(loginTextFieldCollection[1].text!, forKey: "password")
        UserDefaults.standard.set(loginTextFieldCollection[2].text!, forKey: "nickname")
        UserDefaults.standard.set(loginTextFieldCollection[3].text!, forKey: "inviteCode")
        
        
        // 저장 버튼 클릭 횟수 저장 기능
        // 1. 저장된 횟수 가지고 오기
        let value = UserDefaults.standard.integer(forKey: "count")
        // 2. 저장된 횟수에 1을 더하기
        let result = value + 1
        // 3. 2번에서 나온 결과를 다시 저장해 주기
        UserDefaults.standard.set(result, forKey: "count")
        // 4. 확인
        print(UserDefaults.standard.integer(forKey: "count"))
        
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
