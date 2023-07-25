//
//  ViewController.swift
//  EmoteDiary
//
//  Created by yeoni on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pullDownButton: UIBarButtonItem!
    
    @IBOutlet var emoteButtons: [UIButton]!
    
    var addNumber = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenu()
        emoteButtons.forEach { eachButtonTapped(button: $0) }
    }

    
    @IBAction func emoteButtonTapped(_ sender: UIButton) {
        
        let emotionStr = emoteArr[sender.tag].rawValue
        emoteValue[emotionStr]! += addNumber
        addNumber = 1
    }
    
    func eachButtonTapped(button: UIButton) {
        let three = UIAction(title: "3") { _ in
            self.addNumber = 3
            self.emoteButtonTapped(button)
        }
        let five = UIAction(title: "5") { _ in
            self.addNumber = 5
            self.emoteButtonTapped(button)
        }
        let ten = UIAction(title: "10") { _ in
            self.addNumber = 10
            self.emoteButtonTapped(button)
        }
        let buttonMenu = UIMenu(title: "증가할 숫자를 선택하세요", children: [three, five, ten])
//        emoteButtons.forEach { $0.menu = buttonMenu }
        button.menu = buttonMenu

    }
    
    func setMenu() {
        let one = UIAction(title: "1", handler: { _ in self.addNumber = 1 })
        let five = UIAction(title: "5", attributes: .destructive, handler: { _ in self.addNumber = 5 })
        let ten = UIAction(title: "10", attributes: .destructive, handler: { _ in self.addNumber = 10 })
        let buttonMenu = UIMenu(title: "증가할 숫자를 선택하세요", children: [one, five, ten])
        pullDownButton.menu = buttonMenu
    }
    
//    func setupMenu() {
//        let menuClosure = {(action: UIAction) in
//              self.update(number: action.title)
//          }
//        pullDownButton.menu = UIMenu(children: [
//                  UIAction(title: "option 1", state: .on, handler:
//                                      menuClosure),
//                  UIAction(title: "option 2", handler: menuClosure),
//                  UIAction(title: "option 3", handler: menuClosure),
//              ])
//        pullDownButton.changesSelectionAsPrimaryAction = true
//    }
}

