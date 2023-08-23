//
//  ThirdExampleViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/22.
//

import UIKit
import SnapKit

class ThirdExampleViewController: UIViewController {
    
    let locationFrameView = UIView.filterBuilder(color: .darkGray, opacity: 0.1)
    let timeLabel = PaddingLabel.labelBuilder(text: timeDecotter(), size: 14, isChat: false)
    
    let locateButton = UIButton.buttonBuilder(image: UIImage(systemName: "location.fill"), title: "")
    let locationLabel = PaddingLabel.labelBuilder(text: "서울, 연희동", size: 20, isChat: false)
    let shareButton = UIButton.buttonBuilder(image: UIImage(systemName: "square.and.arrow.up"), title: "")
    let refreshButton = UIButton.buttonBuilder(image: UIImage(systemName: "arrow.clockwise"), title: "")
    
    let bgImageView = UIImageView.imageBuilder(image: "pompom", cornerRadius: 0)
    let filterView = UIView.filterBuilder(color: .lightGray, opacity: 0.3)
    let chatImageView = UIImageView.imageBuilder(image: "cloudy", cornerRadius: 10)
    
    let locationStackView = UIStackView.stackViewBuilder(space: 10, axis: .horizontal)
    let chattingStackView = UIStackView.stackViewBuilder(space: 10, axis: .vertical)
    
    let chattingLog: [UIView] = [
        PaddingLabel.labelBuilder(text: "지금은 9도에요", size: 15, isChat: true),
        PaddingLabel.labelBuilder(text: "78% 만큼 습해요", size: 15, isChat: true),
        PaddingLabel.labelBuilder(text: "1m/s의 바람이 불어요", size: 15, isChat: true),
        PaddingLabel.labelBuilder(text: "오늘도 행복한 하루 보내세요!", size: 15, isChat: true)
    ]
    
    let chattingBgView: [UIView] = [UIView()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitView()
        setLayout()
        
        
        
        
        
        
    }
    
    
    func setInitView() {
        [locateButton, locationLabel, shareButton, refreshButton].forEach {
            locationStackView.addSubview($0)
            if $0 != shareButton {
                $0.snp.makeConstraints { make in
                    make.width.height.equalTo(locationStackView.snp.height)
                }
            }
        }
        
        [timeLabel, locationStackView].forEach { locationFrameView.addSubview($0) }
        
        for index in chattingLog.indices {
            let log = chattingLog[index]
            chattingStackView.addArrangedSubview(log)
            log.layer.opacity = 0.95
            log.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            if index == 2 {
                chattingStackView.addArrangedSubview(chatImageView)
                chatImageView.snp.makeConstraints { make in
                    make.height.equalTo(chattingStackView).multipliedBy(0.4)
                }
            }
        }
        
        [bgImageView, filterView, locationFrameView, timeLabel, locationStackView, chattingStackView].forEach {
            view.addSubview($0)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    func setLayout() {
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        filterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationFrameView.layer.cornerRadius = 30
        locationFrameView.layer.borderColor = UIColor.lightGray.cgColor
        locationFrameView.layer.borderWidth = 1
        locationFrameView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(120)
        }
        
        timeLabel.textAlignment = .justified
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(locationFrameView).offset(20)
            make.horizontalEdges.equalTo(locationFrameView).inset(20)
        }
        
        locationStackView.snp.makeConstraints { make in
            make.bottom.equalTo(locationFrameView).inset(20)
            make.horizontalEdges.equalTo(locationFrameView).inset(20)
        }
        
//        locationStackView.snp.makeConstraints { make in
//            make.top.equalTo(timeLabel.snp.bottom).offset(16)
//            make.horizontalEdges.equalTo(timeLabel)
//        }
        
        chattingStackView.snp.makeConstraints { make in
            make.top.equalTo(locationFrameView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.height.equalTo(430)
        }
        
        c
        
    }
    
    
    static func timeDecotter() -> String {
        // Date to String
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        let result = formatter.string(from: now)
        return result
    }
    
}
