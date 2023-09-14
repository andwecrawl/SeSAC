//
//  LottoView.swift
//  MVVMPractice
//
//  Created by yeoni on 2023/09/13.
//

import UIKit
import SnapKit

class LottoView: UIView {
    
    let titleLabel = UILabel.labelBuilder(text: "로또 당첨 번호 조회", size: 20, weight: .bold)
    let priceLabel = UILabel.labelBuilder(text: "당첨금", size: 17, weight: .medium)
    
    let firstBall = UIView.viewBuilder(bgColor: .systemRed)
    let firstLabel = UILabel.labelBuilder(text: "0", size: 15, weight: .regular)
    let secondBall = UIView.viewBuilder(bgColor: .systemOrange)
    let secondLabel = UILabel.labelBuilder(text: "1", size: 15, weight: .regular)
    let thirdBall = UIView.viewBuilder(bgColor: .systemYellow)
    let thirdLabel = UILabel.labelBuilder(text: "2", size: 15, weight: .regular)
    let fourthBall = UIView.viewBuilder(bgColor: .systemGreen)
    let fourthLabel = UILabel.labelBuilder(text: "3", size: 15, weight: .regular)
    let fifthBall = UIView.viewBuilder(bgColor: .systemBlue)
    let fifthLabel = UILabel.labelBuilder(text: "4", size: 15, weight: .regular)
    let sixthBall = UIView.viewBuilder(bgColor: .systemCyan)
    let sixthLabel = UILabel.labelBuilder(text: "5", size: 15, weight: .regular)
    let seventhBall = UIView.viewBuilder(bgColor: .systemPurple)
    let seventhLabel = UILabel.labelBuilder(text: "6", size: 15, weight: .regular)
    
    let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    let chooseStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    let chooseTextField = UITextField.textFieldBuilder(placeholder: "원하는 회차를 골라 보세요!")
    let chooseButton = UIButton.ButtonBuilder(title: "선택")
    
    let pickerView = UIPickerView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
//        self.dd = .white
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        firstBall.addSubview(firstLabel)
        secondBall.addSubview(secondLabel)
        thirdBall.addSubview(thirdLabel)
        fourthBall.addSubview(fourthLabel)
        fifthBall.addSubview(fifthLabel)
        sixthBall.addSubview(sixthLabel)
        seventhBall.addSubview(seventhLabel)
        [firstBall, secondBall, thirdBall, fourthBall, fifthBall, sixthBall, seventhBall].forEach {
            stackView.addArrangedSubview($0)
        }
        
        self.addSubview(stackView)
        self.addSubview(chooseStackView)
        [chooseTextField, chooseButton].forEach {
            chooseStackView.addArrangedSubview($0)
        }
        
        chooseTextField.inputView = pickerView
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        [firstLabel, secondLabel, thirdLabel, fourthLabel, fifthLabel, sixthLabel, seventhLabel].forEach {
            $0.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        chooseStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(stackView)
            make.height.equalTo(50)
        }
        
        chooseButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(100)
            make.trailing.equalToSuperview()
        }
        
        chooseTextField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
    }
    
    
    
    
}

