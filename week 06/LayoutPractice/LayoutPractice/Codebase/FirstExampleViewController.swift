//
//  FirstExampleViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/22.
//

import UIKit

class FirstExampleViewController: UIViewController {

    var diaryImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleAspectFill
//        view.image = UIImage(named: "testImage")
        return view
    }()
    
    let titleTextField = makeBorderField(placeholder: "제목을 입력해 주세요")
    
    let dateTextField = makeBorderField(placeholder: "날짜를 입력해 주세요")
    
    var contentTextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [diaryImageView, titleTextField, dateTextField, contentTextView].forEach { element in
            view.addSubview(element)
            view.backgroundColor = .white
        }
        
        setLayout()
    }
    

    func setLayout() {
        
        diaryImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(250)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(diaryImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

}

extension FirstExampleViewController {
    static func makeBorderField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }
}
