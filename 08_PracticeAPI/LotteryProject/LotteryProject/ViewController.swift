//
//  ViewController.swift
//  LotteryProject
//
//  Created by yeoni on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var LotteryTextField: UITextField!
    
    
    
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1079).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LotteryTextField.inputView = pickerView
        LotteryTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        callRequest(number: 1079)
        designLabel()
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
                
                let nums: [String] = [
                    json["drwtNo1"].stringValue,
                    json["drwtNo2"].stringValue,
                    json["drwtNo3"].stringValue,
                    json["drwtNo4"].stringValue,
                    json["drwtNo5"].stringValue,
                    json["drwtNo6"].stringValue,
                    json["bnusNo"].stringValue
                ]
                let lotteryNumber = nums.joined(separator: " / ")
                
                self.resultLabel.text = lotteryNumber
                self.numberLabel.text = String(number) + "회 당첨 번호"
                
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
   
    
    func designLabel() {
        numberLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.font = .boldSystemFont(ofSize: 17)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callRequest(number: list[row])
        print(list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        LotteryTextField.textAlignment = .center
        LotteryTextField.text = "\(list[row])"
        
        return "\(list[row])"
    }
    
    
}


