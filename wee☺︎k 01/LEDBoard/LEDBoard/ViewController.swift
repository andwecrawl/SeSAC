//
//  ViewController.swift
//  LEDBoard
//
//  Created by yeoni on 2023/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var colorBundle: [UIButton]!
    @IBOutlet var iOView: UIView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var inputText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ""
        resultLabel.textColor = .yellow
        resultLabel.textAlignment = .center
        resultLabel.font.withSize(CGFloat(100))
        resultLabel.numberOfLines = 0
    }
    
   // DidEndonExit으로 설정한 Event ^_^
    @IBAction func inputTextField(_ sender: UITextField) {
        inputText = sender.text ?? ""
    }
    
    @IBAction func changingInputTextField(_ sender: UITextField) {
        inputText = sender.text ?? ""
        resultLabel.text = inputText
    }
    
    @IBAction func colorPickedButton(_ sender: UIButton) {
        resultLabel.textColor = sender.backgroundColor
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if iOView.isHidden {
            iOView.isHidden = false
        } else {
            iOView.isHidden = true
        }
    }
    
    
}

