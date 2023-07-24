//
//  TransitionViewController.swift
//  SeSACWeek2
//
//  Created by yeoni on 2023/07/24.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // 다른 화면에서 transitionViewController로 돌아올 때(unwind) 사용하는 기능
    // action 연결하지 않고, 직접 작성함!
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        // home으로 돌아올 때 transition보다는 unwind라는 표현을 자주 씀 ^_^
        
        
    }

}
