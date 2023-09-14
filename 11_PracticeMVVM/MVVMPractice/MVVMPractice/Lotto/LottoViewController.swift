//
//  LottoViewController.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit

class LottoViewController: UIViewController {
    
    let mainView = LottoView()
    let viewModel = LottoViewModel()
    var drwNo: Int = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindData()
        
        mainView.priceLabel.text = "행운을 빕니다!"
    }
    
    func configureView() {
        mainView.pickerView.delegate = self
        mainView.pickerView.dataSource = self
        
        mainView.chooseButton.addTarget(self, action: #selector(chooseButtonClicked), for: .touchUpInside)
    }
    
    @objc func chooseButtonClicked() {
        self.viewModel.fetchLottoAPI(drwNo: drwNo)
    }
    
    
    func bindData() {
        viewModel.num1.bind { value in
            self.mainView.firstLabel.text = "\(value)"
        }
        
        viewModel.num2.bind { value in
            self.mainView.secondLabel.text = "\(value)"
        }
        
        viewModel.num3.bind { value in
            self.mainView.thirdLabel.text = "\(value)"
        }
        
        viewModel.num4.bind { value in
            self.mainView.fourthLabel.text = "\(value)"
        }
        
        viewModel.num5.bind { value in
            self.mainView.fifthLabel.text = "\(value)"
        }
        
        viewModel.num6.bind { value in
            self.mainView.sixthLabel.text = "\(value)"
        }
        
        viewModel.num7.bind { value in
            self.mainView.seventhLabel.text = "\(value)"
        }
        
        viewModel.price.bind { value in
            self.mainView.priceLabel.text = "당첨금: \(value)원"
        }
        
    }
    
    
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.drwNo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drwNo = viewModel.drwNo.reversed()[row]
        mainView.chooseTextField.text = "\(drwNo)회차"
        mainView.chooseTextField.resignFirstResponder()
        mainView.pickerView.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(viewModel.drwNo.reversed()[row])"
    }
    
    
}
