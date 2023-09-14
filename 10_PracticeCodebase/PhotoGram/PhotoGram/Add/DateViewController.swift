//
//  DateViewController.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    // Protocol 값 전달 2. 프로토콜 실제 생성!!
        // 안에서 필요한 시점에 어떤 부분으로 구현해라!! 하면 댐
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    // 메모리에서 해제되는 시점을 탐지해 주는 거임!!
    deinit {
        print("deinit", self)
    }
    
    // protocol 값 전달 3. 픽커에서 받은 거 전달!!
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.receiveDate(date: mainView.datePicker.date)
    }
    
    
}
