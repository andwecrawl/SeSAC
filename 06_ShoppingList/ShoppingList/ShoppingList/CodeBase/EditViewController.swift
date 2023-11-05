//
//  EditViewController.swift
//  ShoppingList
//
//  Created by yeoni on 2023/07/28.
//

import UIKit

class EditViewController: UIViewController {
    
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var completionHandler: ((String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        title = "수정하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    @objc func saveButtonClicked() {
        guard let text = textField.text else { return }
        
        completionHandler?(text)
        navigationController?.popViewController(animated: true)
        
    }


}

