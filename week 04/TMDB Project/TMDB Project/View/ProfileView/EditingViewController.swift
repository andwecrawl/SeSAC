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
//        view.layer.cornerRadius = 10
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.layer.borderWidth = 1
        return view
    }()
    
    var completionHandler: ((String, String) -> ())?
    
    var setting: SettingName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 저장해서 값 넘겨주는 코드!!
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        guard let setting else { return }
        let str = setting.rawValue
        
        title = str
        switch setting {
        case .Name, .Username, .Bio, .Gender:
            textField.placeholder = "Enter your \(str)"
        case .Pronouns, .Link:
            textField.placeholder = "Enter the \(str)"
        }
        
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
}
