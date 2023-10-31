//
//  RxValidationViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/01.
//

import UIKit
import SnapKit

class RxValidationViewController: UIViewController {
    
    var idLabel = UILabel()
    let idTextField = UITextField()
    let usernameValidOutlet = UILabel()
    
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordValidOutlet = UILabel()
    let button = UIButton()
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .equalSpacing
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
        
    }
    
    func setConstraints() {
        [
            idLabel,
            idTextField,
            usernameValidOutlet,
            passwordLabel,
            passwordTextField,
            passwordValidOutlet,
            button
        ]
            .forEach{ stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        idLabel.text = "Username"
        idTextField.placeholder = "아이디를 입력해 주세용"
        usernameValidOutlet.text = "Label"
        passwordLabel.text = "Password"
        passwordTextField.placeholder = "비밀번호를 입력해 주세용"
        passwordValidOutlet.text = "Label"
        
        button.backgroundColor = .green
    }
    
    
    
}
