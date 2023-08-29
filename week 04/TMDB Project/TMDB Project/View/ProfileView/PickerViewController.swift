//
//  PickerViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/30.
//

import UIKit

class PickerViewController: BaseViewController {
    
    let list = ["Male", "Female", "They / Them"]
    
    let pickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    var setting: SettingName?
    
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(pickerView)
    }
    
    override func setConstraints() {
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
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
        print("\(list[row])")
        completionHandler?("\(list[row])")
    }
    
    
}

