//
//  TranslationPickerViewController.swift
//  PracticeAPi
//
//  Created by yeoni on 2023/08/10.
//

import UIKit

class TranslationPickerViewController: UIViewController {
    
    
    @IBOutlet weak var originTextView: UITextView!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var langPickerView: UIPickerView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultSetting()
        
    }
    
    
    func defaultSetting() {
        title = "다국어 번역기"
        originTextView.text = ""
        translationTextView.text = ""
    }
    

}

extension TranslationPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    
    
}
