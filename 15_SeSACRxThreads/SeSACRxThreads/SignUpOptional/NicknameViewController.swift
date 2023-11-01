//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let nickname = BehaviorSubject(value: "")
    let minimumLetter: Int = 1
    let maximunLetter: Int = 6
    
    let isHidden = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
       
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    
    func bind() {
        
        nickname
            .bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        isHidden
            .bind(to: nextButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        nickname
            .map({ $0.count > 1 && $0.count < 6 })
            .bind(with: self, onNext: { object, value in
                object.isHidden.onNext(!value)
            })
//            .subscribe(with: self, onNext: { object, value in
//                object.isHidden.onNext(!value)
//            })
            .disposed(by: disposeBag)
        
        
        nicknameTextField.rx.text.orEmpty
            .bind(to: nickname)
            .disposed(by: disposeBag)
    }
}
