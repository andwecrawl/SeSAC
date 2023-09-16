//
//  ViewController.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleToFill
        return view
    }()
    let loginTextField = UITextField.textFieldBuilder(placeholder: "이메일 주소 또는 전화번호")
    let passwordTextField = UITextField.textFieldBuilder(placeholder: "비밀번호")
    let nicknameTextField = UITextField.textFieldBuilder(placeholder: "닉네임")
    let locationTextField = UITextField.textFieldBuilder(placeholder: "위치")
    let inviteCodeTextField = UITextField.textFieldBuilder(placeholder: "추천 코드 입력")
    let assignButton = UIButton.buttonBuilder(title: "회원가입")
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    
    func configureView() {
        view.addSubview(logoImageView)
        
        view.addSubview(stackView)
        [loginTextField, passwordTextField, nicknameTextField, locationTextField, inviteCodeTextField, assignButton].forEach { element in
            stackView.addArrangedSubview(element)
            element.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.height.equalTo(40)
            }
        }
        
    }
    
    func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.25)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(80)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
    
    
}

