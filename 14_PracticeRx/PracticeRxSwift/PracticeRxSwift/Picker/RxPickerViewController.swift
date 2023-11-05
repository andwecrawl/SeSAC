//
//  RxPickerViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/10/31.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxPickerViewController: UIViewController {
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    let stackView = {
        let view = UIStackView()
        view.spacing = 0
        view.distribution = .fillEqually
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
        
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        [pickerView1, pickerView2, pickerView3]
            .forEach { pickerView in
                stackView.addArrangedSubview(pickerView)
            }
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) {
                _, item in
                return NSAttributedString(string: "\(item)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected 2: \(models)")
            }
            .disposed(by: disposeBag)
        
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) {
                _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe { models in
                print("models selected 3: \(models)")
            }
            .disposed(by: disposeBag)
    }
    
}
