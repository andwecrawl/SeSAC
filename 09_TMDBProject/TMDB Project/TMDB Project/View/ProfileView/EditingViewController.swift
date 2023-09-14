//
//  EditingViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class EditingViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        return view
    }()
    
    var completionHandler: ((String) -> ())?
    
    var setting: SettingName?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 저장해서 값 넘겨주는 코드!!
        
        guard let text = textField.text else { return }
        completionHandler?(text)
        
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        guard let setting else { return }
        let str = setting.rawValue
        
        title = str
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        switch setting {
        case .Name, .Username, .Bio:
            textField.placeholder = "Enter your \(str)"
        case .Pronouns, .Link:
            textField.placeholder = "Enter the \(str)"
        case .Gender:
            return
        }
        
    }
    
    @objc func saveButtonClicked() {
        // 저장해서 값 넘겨주는 코드!!
        guard let text = textField.text else { return }
        
        completionHandler?(text)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
}

