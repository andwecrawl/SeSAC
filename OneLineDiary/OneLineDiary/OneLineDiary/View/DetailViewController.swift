//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var contentLabel: UIButton!
    
    // Pass Data 1. 데이터를 받을 공간(프로퍼티) 생성
    var contents: String = "빈 공간"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setBackgroundColor()
        
        // 3. 전달 받은 값을 뷰에 표현 (활용)
        print(contents)
        contentLabel.setTitle(contents, for: .normal)
        contentLabel.tintColor = .white
        contentLabel.titleLabel?.numberOfLines = 0
        
    }
    
    // navigationController 이용하여 push -> pop
    // navigationController?.popViewController(animated: true)

    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        
        
        // push - pop (nav)
        navigationController?.popViewController(animated: true)
        
        // navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        // 중간 특정 지점 뷰. 컨
        // 한 단계 pop
        
        
        // navigationController?.popToRootViewController(animated: <#T##Bool#>)
        // 가장 처음 화면으로
    }
    
}
