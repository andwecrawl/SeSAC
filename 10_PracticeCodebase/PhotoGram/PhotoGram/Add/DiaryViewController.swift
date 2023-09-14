//
//  DiaryViewControlelr.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class DiaryViewController: BaseViewController {
    
    let textView = {
        let view = UITextView()
        view.textAlignment = .justified
        view.backgroundColor = .systemGray3
        view.isEditable = true
        return view
    }()
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let greenView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let text = textView.text else { return }
        
        completionHandler?(text, 777, true)
    }
    
    // 메모리에서 해제되는 시점을 탐지해 주는 거임!!
    deinit {
        print("deinit", self)
    }
    
    func setAnimation() {
        // 시작할 때 어떤 모습?
        sampleView.alpha = 0
        greenView.alpha = 0
        
        // 끝날 때는 어떤 모습?
        UIView.animate(withDuration: 1, delay: 2, options: [.repeat, .autoreverse]) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .blue
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.greenView.alpha = 0
            }
        }
 
    }
    
    
    // 만약에 여러 가지를 전달하고 싶다면?
    // (String, Int, Bool) <- 이런 식으로 여러 가지를 묶어서 전달해도 댐~~!!!!!
    var completionHandler: ((String, Int, Bool) -> ())?
    
    override func configureView() {
       super.configureView()
        
        view.addSubview(textView)
        view.addSubview(sampleView)
        
        view.addSubview(greenView)
        setAnimation()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        guard let text = textView.text else { return }
        
        
        completionHandler?(text, 100, false)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(250)
        }
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        greenView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(sampleView).offset(70)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.greenView.alpha = 0.5
            }
        }
    }

    
    
}
