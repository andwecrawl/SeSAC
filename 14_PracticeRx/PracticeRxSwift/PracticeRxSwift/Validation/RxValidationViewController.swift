//
//  RxValidationViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class RxValidationViewController: UIViewController {
    
    var idLabel = UILabel()
    let usernameOutlet = UITextField()
    let usernameValidOutlet = UILabel()
    
    let passwordLabel = UILabel()
    let passwordOutlet = UITextField()
    let passwordValidOutlet = UILabel()
    let button = UIButton()
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .equalSpacing
        return view
    }()
    
    let viewModel = RxValidationViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
        inputOutput()
    }
    
    func setConstraints() {
        [
            idLabel,
            usernameOutlet,
            usernameValidOutlet,
            passwordLabel,
            passwordOutlet,
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
        usernameOutlet.placeholder = "아이디를 입력해 주세용"
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordLabel.text = "Password"
        passwordOutlet.placeholder = "비밀번호를 입력해 주세용"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        button.backgroundColor = .green
    }
    
    
    
    func inputOutput() {
        
        let input = RxValidationViewModel.Input(
            username: usernameOutlet.rx.text,
            password: passwordOutlet.rx.text,
            tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.usernameValidation
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.buttonValidation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    
    var usernameValidation = BehaviorRelay(value: false)
    let passwordValidation = BehaviorRelay(value: false)
    
    func bind() {
        
        usernameOutlet.rx.text.orEmpty
            .map({ $0.count >= 5 })
            .bind(to: usernameValidation)
            .disposed(by: disposeBag)
        
        passwordOutlet.rx.text.orEmpty
            .map({ $0.count >= 5 })
            .bind(to: passwordValidation)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(usernameValidation, passwordValidation)
            .bind(with: self) { owner, validation in
                
                owner.usernameValidOutlet.isHidden = validation.0
                owner.passwordValidOutlet.isHidden = validation.1
                
                let isValidID = validation.0 && validation.1
                let color: UIColor = isValidID ? .blue : .red
                owner.button.isEnabled = isValidID
                owner.button.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    func checkValidations() {
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
