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
    
    let statusLabel = UILabel.labelBuilder(text: "환영합니다!", size: 18, weight: .medium)
    let statusLabel = UILabel.labelBuilder(text: "환영합니다!", size: 19, weight: .medium)
    let loginTextField = UITextField.textFieldBuilder(placeholder: "이메일 주소 또는 전화번호")
    let passwordTextField = UITextField.textFieldBuilder(placeholder: "비밀번호")
    let nicknameTextField = UITextField.textFieldBuilder(placeholder: "닉네임")
    let inviteCodeTextField = UITextField.textFieldBuilder(placeholder: "추천 코드 입력")
    let assignButton = UIButton.buttonBuilder(title: "회원가입")
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    
    func configureView() {
        view.addSubview(logoImageView)
        
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        [loginTextField, passwordTextField, nicknameTextField, inviteCodeTextField, assignButton].forEach { element in
            stackView.addArrangedSubview(element)
            element.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                if element == assignButton {
                    make.height.equalTo(50)
                } else {
                    make.height.equalTo(40)
                }
            }
        }
        
        assignButton.addTarget(self, action: #selector(assignButtonClicked), for: .touchUpInside)
        loginTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        inviteCodeTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc func assignButtonClicked() {
        viewModel.signIn {
            // 화면 전환 코드
        }
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case loginTextField:
            viewModel.id.value = text
            viewModel.checkValidation()
        case passwordTextField:
            viewModel.password.value = text
            viewModel.checkValidation()
        case nicknameTextField:
            viewModel.nickname.value = text
            viewModel.checkValidation()
        case inviteCodeTextField:
            viewModel.inviteCode.value = text
            viewModel.checkValidation()
        default:
            return
        }
    }
    
    func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.33)
        }
        
        stackView.snp.makeConstraints { make in
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func bindData() {
        
        viewModel.id.bind { id in
            self.loginTextField.text = id
        }
        
        viewModel.password.bind { pw in
            self.passwordTextField.text = pw
        }
        
        viewModel.nickname.bind { nickname in
            self.nicknameTextField.text = nickname
        }
        
        viewModel.inviteCode.bind { code in
            self.inviteCodeTextField.text = code
        }
        
        viewModel.isVailed.bind { bool in
            self.assignButton.isEnabled = bool
            self.loginTextField.backgroundColor = bool ? .red : .lightGray
        }
    }
    
    
}

