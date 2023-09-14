//
//  CodeViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/21.
//

import UIKit
import SnapKit

class CodeViewController: UIViewController {
    
    
    let bigButton = UIButton()
    
    let firstTextField = UITextField()
    let firstButton = UIButton()
    let secondButton = UIButton()
    let thirdButton = UIButton()
    
    let shadowView = UIView()
    let shadowViewTwo = UIView()
    let frontButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutWithSnapKit()
        secondButton.addTarget(self, action: #selector(secondButtonClicked), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonClicked), for: .touchUpInside)
        frontButton.addTarget(self, action: #selector(frontButtonClicked), for: .touchUpInside)
    
    }
    
    @objc func secondButtonClicked() {
        let vc = FirstExampleViewController()
        
        present(vc, animated: true)
    }
    
    @objc func thirdButtonClicked() {
        let vc = SecondExampleViewController()
        let nav = UINavigationController(rootViewController: vc)
        
//        nav.pushViewController(nav, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
        
        present(nav, animated: true)
    }
    
    @objc func frontButtonClicked() {
        let vc = ThirdExampleViewController()
        
        present(vc, animated: true)
    }
    
    func setupLayoutWithSnapKit() {
        
        let viewElement = [shadowView, firstButton, secondButton, thirdButton, shadowViewTwo, frontButton, bigButton]
        let colors: [UIColor] = [.magenta, .yellow, .systemMint, .green, .cyan, .black, .red]
        
        for index in viewElement.indices {
            view.addSubview(viewElement[index])
            viewElement[index].translatesAutoresizingMaskIntoConstraints = false
            viewElement[index].backgroundColor = colors[index]
        }
        
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(100)
        }
        
        secondButton.setTitle("1번 예제", for: .normal)
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(20)
            make.width.equalTo(view).multipliedBy(0.42)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(100)
        }
        
        thirdButton.setTitle("2번 예제", for: .normal)
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
            make.width.equalTo(view).multipliedBy(0.42)
            make.height.equalTo(100)
        }
        
        shadowView.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(40)
            make.leading.equalTo(40)
            make.size.equalTo(280)
        }
        
        shadowViewTwo.snp.makeConstraints { make in
            make.leading.equalTo(70)
            make.top.equalTo(shadowView).offset(25)
            make.size.equalTo(280)
        }
        
        frontButton.setTitle("3번 예제", for: .normal)
        frontButton.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(shadowViewTwo.snp.top).offset(20)
            make.size.equalTo(300)
        }
        
        
        bigButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalTo(view.snp.bottom).offset(20)
            make.size.equalTo(view.snp.height).multipliedBy(0.8)
        }
        
        bigButton.layer.cornerRadius = CGFloat(view.bounds.height * 0.9 * 0.5)
        
    }
    
    
    func setupLayoutNSConstraint() {
        
        
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
        NSLayoutConstraint(item: firstTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100).isActive = true
        
        firstTextField.backgroundColor = .yellow
        
        
        
        NSLayoutConstraint(item: firstButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .trailing, relatedBy: .equal, toItem: secondButton, attribute: .leading, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 75).isActive = true
        NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: secondButton, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        firstButton.backgroundColor = .green
        
        
        
        
        NSLayoutConstraint(item: secondButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .leading, relatedBy: .equal, toItem: firstButton, attribute: .trailing, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 75).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: secondButton, attribute: .width, relatedBy: .equal, toItem: firstButton, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        secondButton.backgroundColor = .cyan
        
        
        
        NSLayoutConstraint(item: bigButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .top, relatedBy: .equal, toItem: firstTextField, attribute: .bottom, multiplier: 1, constant: 107).isActive = true
        NSLayoutConstraint(item: bigButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 130).isActive = true
        
        bigButton.backgroundColor = .black
    }
    
    
}
