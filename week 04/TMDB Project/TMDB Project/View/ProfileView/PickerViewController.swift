//
//  PickerViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/30.
//

import UIKit

class PickerViewController: BaseViewController {
    
    let list = ["성별을 선택해 주세요", "Male", "Female", "They / Them"]
    
    let pickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    var delegate: PassTextDelegate?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(pickerView)
        
        title = "Gender"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func saveButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

}


extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 몇 개를 선택할 건지!!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 선택할 수 있는 pickerView의 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    // title을 정해주깅
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            giveAlert(title: "성별을 골라 주세요!", message: "")
            delegate?.receiveText(text: "")
        } else {
            delegate?.receiveText(text: "\(list[row])")
        }
    }
    
}

