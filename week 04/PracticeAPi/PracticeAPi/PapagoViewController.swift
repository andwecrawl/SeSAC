//
//  PapagoViewController.swift
//  PracticeAPi
//
//  Created by yeoni on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class PapagoViewController: UIViewController {
    
    
    @IBOutlet weak var originTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    
    var lang: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "영어 번역기"
        translateTextView.isEditable = false
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        guard let text = originTextView.text else { return }
        
        detectLang(text: text)
        translateWords()
        
    }
    
    
    func detectLang(text: String) {
        
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "tDOtE3zKwnMM6XoHScOX",
            "X-Naver-Client-Secret": APIKey.naverAPI.rawValue
        ]
        let parameter: Parameters = [
            "query": text
        ]
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.lang = json["langCode"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func translateWords() {
        guard !lang.isEmpty else { return }
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "tDOtE3zKwnMM6XoHScOX",
            "X-Naver-Client-Secret": APIKey.naverAPI.rawValue
        ]
        print(lang)
        let parameters: Parameters = [
            "source": lang,
            "target": "en",
            "text": originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
}
