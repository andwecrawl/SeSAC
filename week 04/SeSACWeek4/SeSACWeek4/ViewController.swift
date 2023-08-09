//
//  ViewController.swift
//  SeSACWeek4
//
//  Created by yeoni on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var lotteryTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
         callRequest()
    }
    
    
    
    
    func callRequest() {
        // https가 아니라 http!!!!!
        // 오류 뜸
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20120101"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                // movieNM에 접근하려면 차근차근 파싱해야 함(차근차근 자르깅)
                // 위에서부터 차근차근!
                
                
                let name = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                print("==============================")
                print(name)
                print("==============================")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

