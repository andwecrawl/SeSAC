//
//  BaseViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/28.
//

import UIKit
import SnapKit

// 여기에 import 해놓게 되면 상속받는 모든 뷰 컨트롤러에서 사용하게 된다.
// 모두 사용하지 않는 건 굳이 전체로 import할 게 아니라 특정 뷰 컨트롤러에서 추가해 주는 게 좋을 것임
class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
    }
    
    func configureView() { // addSubview
        view.backgroundColor = .white
    }
    
    func setConstraints() { // 제약조건
    }

}
