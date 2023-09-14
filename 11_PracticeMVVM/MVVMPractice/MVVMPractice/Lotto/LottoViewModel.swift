//
//  LottoViewModel.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/14.
//

import Foundation

class LottoViewModel {
    var drwNo: [Int] {
        get {
            var array: [Int] = []
            for num in 1...1084 {
                array.append(num)
            }
            return array
        }
    }
    let num1 = Observable(1)
    let num2 = Observable(2)
    let num3 = Observable(3)
    let num4 = Observable(4)
    let num5 = Observable(5)
    let num6 = Observable(6)
    let num7 = Observable(7)
    let price = Observable("당첨금")
    
    func format(_ num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: num) ?? ""
    }
    
    func fetchLottoAPI(drwNo: Int) {
        
        APIHelper.shared.requestLotto(drwNo: drwNo) { lotto, message in
            guard let lotto else {
                print(message)
                return
            }
            
            self.num1.value = lotto.drwtNo1
            self.num2.value = lotto.drwtNo2
            self.num3.value = lotto.drwtNo3
            self.num4.value = lotto.drwtNo4
            self.num5.value = lotto.drwtNo5
            self.num6.value = lotto.drwtNo6
            self.num7.value = lotto.bnusNo
            self.price.value = self.format(lotto.totSellamnt)
        }
    }
}
