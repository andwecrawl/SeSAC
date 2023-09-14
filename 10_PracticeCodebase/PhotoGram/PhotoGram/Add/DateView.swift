//
//  DateView.swift
//  PhotoGram
//
//  Created by yeoni on 2023/08/29.
//

import UIKit

class DateView: BaseView {
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        // iOS 13 이후로 inlife / compact가 생김!!
        return picker
    }()
    
    override func configureView() {
        addSubview(datePicker)
    }
    
    override func setConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
