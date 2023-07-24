//
//  ViewController.swift
//  DateCalculator
//
//  Created by yeoni on 2023/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var bg100ImageView: UIImageView!
    @IBOutlet weak var bg200ImageView: UIImageView!
    @IBOutlet weak var bg300ImageView: UIImageView!
    @IBOutlet weak var bg400ImageView: UIImageView!
    
    @IBOutlet weak var date100Label: UILabel!
    @IBOutlet weak var date200Label: UILabel!
    @IBOutlet weak var date300Label: UILabel!
    @IBOutlet weak var date400Label: UILabel!
    
    @IBOutlet weak var displayView: UIView!
    
    @IBOutlet weak var view400: UIView!
    @IBOutlet weak var view300: UIView!
    @IBOutlet weak var view100: UIView!
    @IBOutlet weak var view200: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageBundle = [
            bg100ImageView!,
            bg200ImageView!,
            bg300ImageView!,
            bg400ImageView!
        ]
        
        let viewBundle = [
            view100!,
            view200!,
            view300!,
            view400!
        ]
        
        designDatePicker()
        testViewProperty(viewBundle: viewBundle)
        datePickerValueChanged(datePicker)
        
        for image in imageBundle {
            image.layer.cornerRadius = 20
        }
    }
    
    
    func testViewProperty(viewBundle: [UIView]) {
        
        for view in viewBundle {
            view.layer.cornerRadius = 20
            
            view.layer.shadowColor = UIColor.black.cgColor
            
            // 햇빛이 비치는 방향
            view.layer.shadowOffset = .zero
            // zero = CGSize(width: 0, height: 0)
            
            // 퍼짐의 정도
            view.layer.shadowRadius = 10
            
            // 불투명도 (0에서 1)
            view.layer.shadowOpacity = 0.5
            view.clipsToBounds = false
        }
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // 100일 뒤
        let result100 = Calendar.current.date(byAdding: .day, value: 100, to: sender.date)
        
        // 200일 뒤
        let result200 = Calendar.current.date(byAdding: .day, value: 200, to: sender.date)
        
        // 300일 뒤
        let result300 = Calendar.current.date(byAdding: .day, value: 300, to: sender.date)
        
        // 1년 뒤
        let result400 = Calendar.current.date(byAdding: .day, value: 365, to: sender.date)
        
        
        /*
         dateFormatter
         1. 시간대 변경
         2. 날짜 포맷 변경
         */
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value100 = format.string(from: result100!)
        let value200 = format.string(from: result200!)
        let value300 = format.string(from: result300!)
        let value400 = format.string(from: result400!)
        
        date100Label.text = value100
        date200Label.text = value200
        date300Label.text = value300
        date400Label.text = value400
        
        
        
    }
    
    
    
    func designDatePicker() {
        
        datePicker.tintColor = .systemIndigo
        
        // @available (iOS 14, *)
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
            datePicker.preferredDatePickerStyle = .wheels
        }
        
    }
    
}

