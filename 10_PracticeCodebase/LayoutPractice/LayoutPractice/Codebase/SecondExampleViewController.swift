//
//  SecondExampleViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/22.
//

import UIKit

class SecondExampleViewController: UIViewController {
    
    let nameLabel = PaddingLabel.labelBuilder(text: "neenee", size: 20, isChat: false)
    let messageLabel = PaddingLabel.labelBuilder(text: "배고파용", size: 14, isChat: false)
    let xButton = UIButton.buttonBuilder(image: UIImage(systemName: "xmark"), title: "", cornerRadius: 16)
    let giftButton = UIButton.buttonBuilder(image: UIImage(systemName: "qrcode"), title: "", cornerRadius: 16)
    let qrButton = UIButton.buttonBuilder(image: UIImage(systemName: "qrcode"), title: "", cornerRadius: 16)
    let cameraButton = UIButton.buttonBuilder(image: UIImage(systemName: "camera"), title: "", cornerRadius: 0)
    let chattingButton = UIButton.buttonBuilder(image: UIImage(systemName: "bubble.left.fill"), title: "나와의 채팅", cornerRadius: 0)
    let profilButton = UIButton.buttonBuilder(image: UIImage(systemName: "pencil"), title: "프로필 편집", cornerRadius: 0)
    let storyButton = UIButton.buttonBuilder(image: UIImage(systemName: "ellipsis.rectangle"), title: "카카오스토리", cornerRadius: 0)
    
    var bgImageView = UIImageView.imageBuilder(image: "bgImage", cornerRadius: 0)

    
    var profileImageView = UIImageView.imageBuilder(image: "testImage", cornerRadius: 30)
    
    
    let filterView = UIView.filterBuilder(color: .black, opacity: 0.3)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setLayout()
    }
    
    
    func setLayout() {
        [bgImageView, filterView, xButton, giftButton, qrButton, cameraButton, profileImageView, chattingButton, profilButton, storyButton, nameLabel, messageLabel].forEach { element in
            view.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
        
        filterView.snp.makeConstraints { make in
            make.size.equalTo(bgImageView)
        }
        
        xButton.layer.borderWidth = 0
        xButton.snp.makeConstraints { make in
            make.size.equalTo(33)
            make.leading.equalTo(8)
            make.top.equalTo(20)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.size.equalTo(33)
            make.trailing.equalTo(-8)
            make.top.equalTo(33)
        }
        
        qrButton.snp.makeConstraints { make in
            make.size.equalTo(33)
            make.trailing.equalTo(cameraButton.snp.leading).offset(-8)
            make.top.equalTo(cameraButton)
        }
        
        giftButton.snp.makeConstraints { make in
            make.size.equalTo(33)
            make.trailing.equalTo(qrButton.snp.leading).offset(-8)
            make.top.equalTo(qrButton)
        }
        
        chattingButton.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.trailing.equalTo(profilButton.snp.leading).offset(-10)
        }
        
        profilButton.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.centerX.equalTo(view)
            make.bottom.equalTo(chattingButton.snp.bottom)
        }
        
        storyButton.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.bottom.equalTo(chattingButton.snp.bottom)
            make.leading.equalTo(profilButton.snp.trailing).offset(10)
        }
        
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(95)
            make.bottom.equalTo(profilButton.snp.top).inset(-70)
            make.centerX.equalTo(view)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
    }
}
