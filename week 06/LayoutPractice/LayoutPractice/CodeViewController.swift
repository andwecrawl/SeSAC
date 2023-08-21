//
//  CodeViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/21.
//

import UIKit

class CodeViewController: UIViewController {
    
    
    let firstTextField = UITextField()
    let firstButton = UIButton()
    let secondButton = UIButton()
    
    let bigButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        
        
    }
    
    
    func setupLayout() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(firstTextField)
        view.addSubview(bigButton)
        
        
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        bigButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint(item: firstTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: firstTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45).isActive = true
        
        firstTextField.backgroundColor = .yellow
        
        
        
        NSLayoutConstraint(item: firstButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .trailing, relatedBy: .equal, toItem: secondButton, attribute: .leading, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: secondButton, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        firstButton.backgroundColor = .green
        
        
        
        
        NSLayoutConstraint(item: secondButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .leading, relatedBy: .equal, toItem: firstButton, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .width, relatedBy: .equal, toItem: firstButton, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        secondButton.backgroundColor = .cyan
        
        
        
        NSLayoutConstraint(item: bigButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 82).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .width, relatedBy: .equal, toItem: bigButton, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        bigButton.backgroundColor = .black
    }
    
    
}
