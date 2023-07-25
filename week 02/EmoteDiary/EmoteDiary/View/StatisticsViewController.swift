//
//  StatisticsViewController.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    
    @IBOutlet var innerViewBundle: [UIView]!
    @IBOutlet var informationLabelBundle: [UILabel]!
    @IBOutlet var resultLabelBundle: [UILabel]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designView()
        designLabel()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelValue()
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        for index in informationLabelBundle.indices {
            let emotion = informationLabelBundle[index].text!
            emoteValue[emotion] = 0
            resultLabelBundle[index].text = "0점"
            print("reset")
            print(emoteValue)
        }
    }
    
    
    
    
    func updateLabelValue() {
        
        for index in 0...4 {
            let informationLabel = informationLabelBundle[index].text!
            resultLabelBundle[index].text = "\(emoteValue[informationLabel]!)점"
        }
        
    }
    
    
    func designLabel() {
        
        for index in 0...4 {
            
            // 왼쪽 Label Design
            let informationLabel = informationLabelBundle[index]
            informationLabel.text = emoteArr[index].rawValue
            informationLabel.font = UIFont.systemFont(ofSize: 18)
            labelShadow(label: informationLabel)
            
            // 오른쪽 Label Design
            let resultLabel = resultLabelBundle[index]
            let emotionStr = emoteArr[index].rawValue
            resultLabel.text = "\(emoteValue[emotionStr]!)점"
            resultLabel.font = UIFont.boldSystemFont(ofSize: 24)
            labelShadow(label: resultLabel)
        }
    }
    
    
    func labelShadow(label: UILabel) {
        
        label.textColor = .white
        label.layer.shadowColor = UIColor.darkGray.cgColor
        label.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 0.4
        
    }
    
    
    
    func designView() {
        
        for view in innerViewBundle {
            view.layer.cornerRadius = 10
        }
        
        for view in innerViewBundle {
            view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.2
        }
        
    }
}
