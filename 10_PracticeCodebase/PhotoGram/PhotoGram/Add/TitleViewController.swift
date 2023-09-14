//
//  TitleViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해 주세요"
        return view
    }()
    
    // 메모리에서 해제되는 시점을 탐지해 주는 거임!!
    deinit {
        print("deinit", self)
    }
    
    // Closure로 값전달 1.
    var completionHandler: ((String) -> ())?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            // safeAreaLayoutGuide 아이폰 X가 등장하면서~ 더 의미가 있어졌음~
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
            
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 완벽하게 사라져야 disappear method가 실행댐
        // Closure 값 전달 2.
            // 3에서 전달한 클로저의 값이 이 아래에 그대로 들어가서 실행댐
        completionHandler?(textField.text!)
        
    }
    
    
}
