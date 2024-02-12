//
//  PickerViewController.swift
//  OneLineDiary
//
//  Created by yeoni on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

// UI 요소 => class로 되어 있음
// PickerViewDataSource / PickerViewDelegate
// default => nil -> 우리가 설정해야 댐!!

// didSelectRow... SelectRow... Section 대신 comonent명칭 씀 number of 어적고 in component
class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bonusNumberLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    
    // 픽커뷰를 쓰겟다는 선언
    let pickerView = UIPickerView()
    
    
    var list: [Int] = Array(1...1100).reversed()
    // Array(repeating: "gg", count: 100)
    //["영화", "드라마", "애니메이션", "SF", "로맨스", "가족", "코미디"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        callRequest(number: 1079)
        
    }
   
    // 다른 사람들은 어떻게 네이밍을 할까? 검색해 봐도 좋을듯
    func callRequest(number: Int) {
        // url에  link 넣어주기
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            // 인터넷이 잘댐
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue
                
                print(data, bonusNumber)
                self.dateLabel.text = data
                self.bonusNumberLabel.text = "\(bonusNumber)번"
                
                
            // 인터넷이 안댐?
            case .failure(let error):
                print(error)
            }
            
            // => request가 끝날 때까지 기다리지 않음!!
            // 일단 순서대로 실행하지만, 중간에 큰 작업이라면 중간에 다른 스레드에 맡김

        }
        
        // alamofire의 경우 어떤 경우에서는 어디까지 성공으로 치자! 하는 거임
        // 그때 .validate(statusCode: 200...399) <- 200...399까지도 성공으로 쳐주자! 하고 치는 거임
        // status code를 통해 포함시키는 방향으루 가는 거임
        // 보통 .validate()로 되어 있으면 200...299까지 넣은 거라고 보면 댐
        
        // JSON Dictionary 형태 key - value
        // key값이 정확한지 확인 / 타입 확인
    }
    
    
    // 좌우로 픽커가 두 개 나옴
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // 각 컴포넌트에 셀 몇 개 넣을 건데???
    // 볼 셀의 갯수 세기!!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select \(row)")
        
        numberTextField.text = "\(list[row])"
        callRequest(number: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }


}
