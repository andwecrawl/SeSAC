//
//  JoinViewController.swift
//  SACdyBuddy
//
//  Created by yeoni on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa

enum VCType: String {
    case email = "이메일을 입력해 주세요."
    case password = "비밀번호를 입력해 주세요."
    case end = "환영합니다!"
    
    var requirement: String {
        switch self {
        case .email:
            return "email은 추후 ID로 사용돼요!"
        case .password:
            return "대소문자와 숫자를 포함하여 6자 이상 작성해 주세요!"
        case .end:
            return "00에서 즐거운 시간을 보내세요 🔥"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:
            return "ex) aaa123@ssacmail.com"
        case .password:
            return "비밀번호를 입력해 주세요!"
        case .end:
            return ""
        }
    }
}

class JoinViewController: BaseViewController {
    
    let informationLabel = {
        let label = UILabel()
        label.text = "이메일을 입력해 주세요."
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "몇 자 이상 입력해 주세요!"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .systemGray2
        return label
    }()
    
    let inputTextField = {
        let textField = UITextField()
        textField.placeholder = "무언가를 입력해 주세요!"
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()
    
    let lineView = UIView()
    
    let nextButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGreen
        config.title = "다음으로"
        button.configuration = config
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    var VCType: VCType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            informationLabel,
            descriptionLabel,
            inputTextField,
            lineView,
            nextButton
        ]
            .forEach({ view.addSubview($0) })
        
    }
    
    override func setConstraints() {
        
        informationLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(informationLabel)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(informationLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(inputTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(inputTextField)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(52)
        }
        
    }
    
    override func configureView() {
        
        informationLabel.text = VCType?.rawValue
        descriptionLabel.text = VCType?.requirement
        lineView.backgroundColor = .gray
    }
    
    let isValid = BehaviorSubject(value: false)
    
    func bind() {
        
        inputTextField.rx.text.orEmpty
            .map { str in
                switch self.VCType {
                case .email:
                    return (str.range(of: RegexType.email.rawValue, options: .regularExpression) != nil)
                case .password:
                    return (str.range(of: RegexType.password.rawValue, options: .regularExpression) != nil)
                default:
                    return false
                }
            }
            .bind(to: isValid)
            .disposed(by: disposeBag)
        
        
        isValid
            .bind(with: self) { owner, isValid in
                
                owner.nextButton.isEnabled = isValid
                var config = UIButton.Configuration.filled()
                config.baseBackgroundColor = isValid ? .systemGreen : .gray
                owner.nextButton.configuration = config
                
                owner.lineView.backgroundColor = isValid ? .systemGreen : .systemRed
            }
            .disposed(by: disposeBag)
        
        
        nextButton.rx.tap
            .bind(with: self, onNext: { owner, _ in
                
                if owner.VCType == .email {
                    
                    let vc = JoinViewController()
                    vc.VCType = .password
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                } else {
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let SceneDelegate = windowScene?.delegate as? SceneDelegate
                    
                    let vc = HomeViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    
                    SceneDelegate?.window?.rootViewController = nav
                    SceneDelegate?.window?.makeKeyAndVisible()
                    
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    
}
