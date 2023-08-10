//
//  TranslationPickerViewController.swift
//  PracticeAPi
//
//  Created by yeoni on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationPickerViewController: UIViewController {
    
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var originTextView: UITextView!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var langPickerView: UIPickerView!
    
    
    let list = [
        "en", "ja", "zh-CN", "zh-TW",
        "vi", "id", "th", "de",
        "ru", "es", "it", "fr"
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langPickerView.delegate = self
        langPickerView.dataSource = self
        defaultSetting()
        
    }

    
    
    func callRequest(text: String, lang: String) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "tDOtE3zKwnMM6XoHScOX",
            "X-Naver-Client-Secret": APIKey.naverAPI.rawValue
        ]
        var parameter: Parameters = [
            "source": "ko",
            "target": lang,
            "text": text
        ]
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                self.translationTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}



extension TranslationPickerViewController {
    func defaultSetting() {
        title = "다국어 번역기"
        originTextView.text = ""
        translationTextView.text = ""

        originLabel.text = "번역할 문장을 한국어로 작성해 주세요!"
        resultLabel.text = "결과창입니다"
        
        originTextView.layer.borderWidth = 1
        originTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        originTextView.layer.cornerRadius = 15
        translationTextView.layer.borderWidth = 1
        translationTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        translationTextView.layer.cornerRadius = 15
        translationTextView.isEditable = false
        originLabel.textColor = .darkGray
        originLabel.font = .boldSystemFont(ofSize: 15)
        resultLabel.textColor = .darkGray
        resultLabel.font = .boldSystemFont(ofSize: 15)
    }
}



extension TranslationPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let text = originTextView.text else { return }
        callRequest(text: text, lang: list[row])
        
    }
    
    // Picker 좌우로 몇 개 둘 건지!!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 볼의 셀 갯수 세기!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
    
    
}
