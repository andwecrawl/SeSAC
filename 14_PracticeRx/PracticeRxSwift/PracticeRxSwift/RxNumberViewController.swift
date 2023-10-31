//
//  RxNumberViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxNumberViewController: UIViewController {
    
    let numberTextField = UITextField()
    let numberTextField1 = UITextField()
    let numberTextField2 = UITextField()
    
    let result = UILabel()
    
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
    }
    
    func setConstraints() {
        
        [
            numberTextField,
            numberTextField1,
            numberTextField2,
            result
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        Observable.combineLatest(numberTextField.rx.text.orEmpty, numberTextField1.rx.text.orEmpty, numberTextField2.rx.text.orEmpty) {
            value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    
    
}
