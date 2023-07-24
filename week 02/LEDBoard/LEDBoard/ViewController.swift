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
    
    let colorArr: [UIColor] = [
        UIColor.red,
        UIColor.yellow,
        UIColor.green,
        UIColor.orange,
        UIColor.systemMint,
        UIColor.purple,
        UIColor.white,
        UIColor.systemTeal
    ]
    
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ""
        resultLabel.textColor = .yellow
        resultLabel.textAlignment = .center
        resultLabel.font.withSize(CGFloat(100))
        resultLabel.numberOfLines = 0
        
        makeGlow(color: UIColor.yellow)
        
        
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
        if colorBundle.contains(sender) {
            
            let color = sender.backgroundColor!
            resultLabel.textColor = color
            makeGlow(color: color)
            
        } else {
            
            let randomColor = colorArr.randomElement()!
            
            resultLabel.textColor = randomColor
            makeGlow(color: randomColor)
        }
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        iOView.isHidden.toggle()
        
        /*
        if iOView.isHidden {
            iOView.isHidden = false
        } else {
            iOView.isHidden = true
        }
         */
    }
    
    
    @IBAction func makeAnimation(_ sender: UIButton) {
        // timer / dispatchqueue
        if sender.titleLabel?.text == "Animate" {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeAnimating), userInfo: nil, repeats: true);
            sender.setTitle("Unanimate", for: .normal)
        } else {
            timer?.invalidate()
            sender.setTitle("Animate", for: .normal)
        }
    }
    
    
    func makeGlow(color: UIColor) {
        resultLabel.layer.shadowColor = color.cgColor
        resultLabel.layer.shadowOffset = .init(width: 1.5, height: 1.5)
        resultLabel.layer.shadowRadius = 7.0
        resultLabel.layer.shadowOpacity = 1.0
        resultLabel.layer.masksToBounds = false
        resultLabel.layer.shouldRasterize = true
    }
    
    
    
    
    @objc func makeAnimating() {
        UIView.animate(withDuration: TimeInterval(0.1)) { [self] in
            let randomColor = colorArr.randomElement()!
            resultLabel.textColor = randomColor
            makeGlow(color: randomColor)
        }
    }
}

