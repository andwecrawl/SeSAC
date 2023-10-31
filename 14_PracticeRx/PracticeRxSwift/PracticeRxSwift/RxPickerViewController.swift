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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
        
    }
    
    func setConstraints() {
        
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
        
        
        
    }
    
}
