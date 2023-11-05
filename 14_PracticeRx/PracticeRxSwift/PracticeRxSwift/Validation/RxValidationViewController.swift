//
//  RxValidationViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/01.
//

import UIKit
import SnapKit
import RxSwift

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
        checkValidations()
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
        usernameValidOutlet.text = "Label"
        passwordLabel.text = "Password"
        passwordOutlet.placeholder = "비밀번호를 입력해 주세용"
        passwordValidOutlet.text = "Label"
        
        button.backgroundColor = .green
    }
    
    func checkValidations() {
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
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
