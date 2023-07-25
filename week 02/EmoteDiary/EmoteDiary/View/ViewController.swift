//
//  ViewController.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var emoteButtons: [UIButton]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func emoteButtonTapped(_ sender: UIButton) {
        
        let emotionStr = emoteArr[sender.tag].rawValue
        emoteValue[emotionStr]! += 1
        
        /*
        var buttonEmotion: Emote?
        for index in 0...4 {
            if sender == emoteButtons[index] {
                switch index {
                case 0:
                    buttonEmotion = .happy
                case 1:
                    buttonEmotion = .good
                case 2:
                    buttonEmotion = .soso
                case 3:
                    buttonEmotion = .notBad
                default:
                    buttonEmotion = .bad
                }
            }
        }
        
        if let emotionStr = buttonEmotion?.rawValue {
            emoteValue[emotionStr]! += 1
            print(emotionStr, emoteValue[emotionStr]!)
        }
        */
        
    }
    
    
    
    
    

}

