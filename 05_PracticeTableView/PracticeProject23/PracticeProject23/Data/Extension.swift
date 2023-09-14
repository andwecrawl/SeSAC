//
//  Extension.swift
//  PracticeProject23
//
//  Created by yeoni on 2023/07/27.
//

import UIKit

extension UITableViewController {
    
    func giveAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}

extension UILabel {
    
    func configureTitleText() {
        self.textColor = .green
        self.font = .boldSystemFont(ofSize: 20)
        self.textAlignment = .center
    }
    
}
