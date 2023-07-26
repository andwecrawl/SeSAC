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
        
        // 여기서 UserDefault값을 가지고 와서 각 emotion Dictionary값에 넣어주고
        // 이후에는 updateValue로 하면 되지 않을까?!
        loadUserDefault()
        designView()
        designLabels()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelValue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveUserDefault()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        for index in informationLabelBundle.indices {
            let emotion = informationLabelBundle[index].text!
            
            emoteValue[emotion] = 0
            resultLabelBundle[index].text = "0점"
        }
        resetUserDefault()
    }
    
    
    
    func updateLabelValue() {
        
        for index in 0...4 {
            resultLabelBundle[index].text = "\(emoteValue[Emote(rawValue: index)?.tag ?? "0"]!)점"
        }
        
    }
    
    
    func designLabels() {
        
        for index in informationLabelBundle.indices {
            
            // 왼쪽 Label Design
            let informationLabel = informationLabelBundle[index]
            informationLabel.text = Emote(rawValue: index)?.tag
            informationLabel.font = UIFont.systemFont(ofSize: 18)
            labelShadow(label: informationLabel)
            
            // 오른쪽 Label Design
            let resultLabel = resultLabelBundle[index]
            // resultLabel.text = "\(emoteValue[informationLabel.text!]!)점"
            loadUserDefault()
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
            view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.2
        }
        
    }
    
    
    func loadUserDefault() {
        
        let happy = UserDefaults.standard.integer(forKey: "happy")
        let good = UserDefaults.standard.integer(forKey: "good")
        let soso = UserDefaults.standard.integer(forKey: "soso")
        let notBad = UserDefaults.standard.integer(forKey: "notBad")
        let bad = UserDefaults.standard.integer(forKey: "bad")
        
        emoteValue[Emote.happy.tag]! = happy
        emoteValue[Emote.good.tag]! = good
        emoteValue[Emote.soso.tag]! = soso
        emoteValue[Emote.notBad.tag]! = notBad
        emoteValue[Emote.bad.tag]! = bad
        
    }
}
