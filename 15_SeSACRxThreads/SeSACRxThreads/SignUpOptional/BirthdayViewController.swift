//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorSubject(value: 0)
    let month = BehaviorSubject(value: 0)
    let day = BehaviorSubject(value: 0)
    
    let buttonColor = BehaviorSubject(value: UIColor.red)
    let isEnabled = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        
    }
    
    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func bind() {
        
        isEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonColor
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .bind(to: birthday)
            .disposed(by: disposeBag)
        
        birthday
            .subscribe(with: self) { owner, date in
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                if let year = components.year, let month = components.month, let day = components.day {
                    owner.year.onNext(year)
                    owner.month.onNext(month)
                    owner.day.onNext(day)
                }
                
                let compareResult = date.compare(Date().beforeSeventeenYears)
                let isValid = compareResult == .orderedDescending ? false : true
                let color: UIColor = isValid ? .blue : .red
                owner.isEnabled.onNext(isValid)
                owner.buttonColor.onNext(color)
            }
            .disposed(by: disposeBag)
        
        
        year
            // UI Mainthread에서 동작하도록!!
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { object, value in
                object.yearLabel.text = "\(value)년"
            }
            .disposed(by: disposeBag)
        
        month
            .map({ "\($0)월" })
            .subscribe(with: self) { object, str in
                object.monthLabel.text = str
            }
            .disposed(by: disposeBag)
        
        day
            .map({ "\($0)일" })
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { Object, _ in
                Object.showAlert()
            }
            .disposed(by: disposeBag)
    }

    
    func showAlert() {
        let alert = UIAlertController(
            title: "가입 완료!",
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
