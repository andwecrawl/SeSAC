//
//  ViewController+.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/09/06.
//

import UIKit

extension UIViewController {
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}
