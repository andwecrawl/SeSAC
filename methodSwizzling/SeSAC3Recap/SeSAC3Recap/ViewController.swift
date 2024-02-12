//
//  ViewController.swift
//  SeSAC3Recap
//
//  Created by yeoni on 2023/12/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        ViewController.methodSwizzling()
    }


}

extension UIViewController {
    
    // static func vs class func
        // objc 때부터 존재 .. 함 ..
    class func methodSwizzling() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        // 원래 method가 어디에 있는지 물보는 거임
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin),
              let changeMethod = class_getInstanceMethod(UIViewController.self, change)
        else {
            print("함수를 찾을 수 없더요")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
        
    }
    
    
    @objc func changeViewWillAppear() {
        // 앱 분석 특징 가능
        print(#function)
        
    }
    
}
