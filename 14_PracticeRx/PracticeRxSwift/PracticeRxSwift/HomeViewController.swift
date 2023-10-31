//
//  HomeViewController.swift
//  PracticeRxSwift
//
//  Created by yeoni on 2023/10/31.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tableViewButton = UIButton()
    let pickerButton = UIButton()
    let validationButton = UIButton()
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillEqually
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureView()
    }
    
    
    func setConstraints() {
        view.backgroundColor = .white
        
        [
            tableViewButton,
            pickerButton,
            validationButton
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func configureView() {
        
        tableViewButton.backgroundColor = .green
        pickerButton.backgroundColor = .yellow
        validationButton.backgroundColor = .blue
        
        tableViewButton.addTarget(self, action: #selector(tableViewButtonClicked), for: .touchUpInside)
        pickerButton.addTarget(self, action: #selector(pickerButtonClicked), for: .touchUpInside)
        validationButton.addTarget(self, action: #selector(validationButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func validationButtonClicked() {
        let vc = RxValidationViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tableViewButtonClicked() {
        let vc = RxTableViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pickerButtonClicked() {
        
        let vc = RxPickerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
