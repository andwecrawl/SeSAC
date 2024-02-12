//
//  ViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

    

// 1. 부하직원 불러오기 (UITextViewDelegate)
// 2. 둘이 연결해 주기 (editingTextView.delegate = self)
// 3. 관련된 기능 사용
class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var editingTextView: UITextView!
    
    var type: TransitionType = .add
    var contents: String = ""
    
    // placeholder
    let placeholder = "내용을 입력해주세요."
    
    // 뷰와 프로토콜을 연결해 줄 것
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setBackgroundColor()
        
        // 지금 스스로한테 연결되어 자료를 받는 거임
        // 다른 사람한테 주고 싶으면 다른 곳에!!
        editingTextView.delegate = self
        editingTextView.text = contents
        
        
        if editingTextView.text.count == 0 {
            editingTextView.text = placeholder
            editingTextView.textColor = .lightGray
        }
        
        
        title = type.rawValue
        
        // 추가 화면일 때는 빈 텍스트뷰를, 수정 화면일 때는 이전 내용을 값 전달해서 텍스트뷰에 보여주기.
        if case .add = type {
            let xMark = UIImage(systemName: "xmark")
            
            
            // 99.9% style: .plain / target: self
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMark, style: .plain, target: self, action: #selector(closeButtonClicked))
            // #selector 괄호 안에는 함수 이름만 작성해 주어야 함
            // 함수 실행 XXX!!!
            
            navigationItem.leftBarButtonItem?.tintColor = .yellow
        }
        
        
        // barButtonItem의 경우에는 왼쪽은 left / 오른쪽은 right
        // 두 개의 경우에는 items
        
        /*
         title과 image 형태를 결합해서 하려고 하는 경우
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: <#T##UIView#>)
        */
        
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)글자"
    }
    
    
    // 편집이 시작될 때(커서가 시작될 때)
    // placeholder와 textView 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝날 때(커서가 없어지는 순간)
    // 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자가 보이게 설정!!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    
    @objc
    func closeButtonClicked() {
        
        
        // present -> dismiss
        dismiss(animated: true)
        
        // navigationController 이용하여 push -> pop
        // navigationController?.popViewController(animated: true)
    }
    
    
    
    

}

