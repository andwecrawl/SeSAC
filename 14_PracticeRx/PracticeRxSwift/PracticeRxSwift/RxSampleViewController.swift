//
//  RxSampleViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

class RxSampleViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    
    // Subject: Observable + Observer (이벤트를 전달 + 처리 가능)
    let publish = PublishSubject<Int>() // 초깃값을 설정해 주지 않아도 ㄱㅊ
    let behavior = BehaviorSubject(value: 200) // 초깃값 설정해 주어야 함
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureView()
        practiceSubject()
        bind()
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        
    }
    
    func practiceSubject() {
        
        publish.onNext(20)
        publish.onNext(21)
        
        publish
            .subscribe { value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish completed")
            } onDisposed: {
                print("publish disposed")
            }
            .disposed(by: disposeBag)
        
        publish.onNext(1)
        publish.onNext(2)
        publish.onNext(3)
        publish.onCompleted()
        publish.onNext(100)
        publish.onNext(200)
        
        behavior.onNext(201)
        behavior.onNext(202)
        
        behavior
            .subscribe { value in
                print("behavior - \(value)")
            } onError: { error in
                print("behavior - \(error)")
            } onCompleted: {
                print("behavior completed")
            } onDisposed: {
                print("behavior disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(403)
        behavior.onNext(404)
        behavior.onNext(500)
        behavior.onCompleted()
        behavior.onNext(600)
    }
    
    func bind() {
        
        button.rx.tap
            .observe(on: MainScheduler.instance) // UI
            .subscribe { _ in
                self.label.text = "안뇽하세요?"
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .withUnretained(self)
            .observe(on: MainScheduler.instance) // UI
            .subscribe(onNext: { owner, _ in
                owner.label.text = "안뇽하세요?"
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .observe(on: MainScheduler.instance) // UI
            .subscribe { [weak self] _ in
                self?.label.text = "안뇽하세요?"
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .observe(on: MainScheduler.instance) // UI
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.label.text = "안뇽하세요?"
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .observe(on: MainScheduler.instance) // UI
            .subscribe(with: self, onNext: { owner, _ in
                self.label.text = "안뇽하세요?"
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(with: self) { object, _ in
                object.label.text = "안뇽하세요?"
            }
        
        button.rx.tap
            .map({ "안뇽하세요?" }) // 데이터 전달인듯?!
            .bind(to: label.rx.text) // bind...
            .disposed(by: disposeBag)
        
    }
    
    
    
}
