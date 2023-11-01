//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let phone = BehaviorSubject(value: "010")
    let isEnabled = BehaviorSubject(value: false)
    let buttonColor = BehaviorSubject(value: UIColor.red)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
    func bind() {
        isEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonColor
            .bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        buttonColor
            .map({ $0.cgColor })
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        phone
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        phone
            .map({ $0.count > 12 })
            .subscribe(with: self) { owner, value in
                
                let color = value ? UIColor.blue : UIColor.red
                owner.buttonColor.onNext(color)
                owner.isEnabled.onNext(value)
                owner.isEnabled.on(.next(value))
                
            }
            .disposed(by: disposeBag)
        
        
        /*
        phone
            .map({ $0.count > 10 })
            .withUnretained(self)
            .subscribe { object, value in
                let color = value ? UIColor.blue : UIColor.red
                object.buttonColor.onNext(color)
                object.isEnabled.onNext(value)
                object.isEnabled.on(.next(value))
            }
            .disposed(by: disposeBag)
        
        // 메모리 누수가 날 수 있음 :3,,
        phone
            .map({ $0.count > 10 })
            .subscribe { value in
                let color = value ? UIColor.blue : UIColor.red
                self.buttonColor.onNext(color)
                self.isEnabled.onNext(value)
                self.isEnabled.on(.next(value))
            }
            .disposed(by: disposeBag)
         */
        
        phoneTextField.rx.text.orEmpty
            .subscribe(with: self, onNext: { object, value in
                let result = value.formated(by: "###-####-####")
                object.phone.onNext(result)
            })
            .disposed(by: disposeBag)
        
//        phoneTextField.rx.text.orEmpty
//            .subscribe { value in
//                let result = value.formated(by: "###-####-####")
//                self.phone.onNext(result)
//            }
        
    }

}
