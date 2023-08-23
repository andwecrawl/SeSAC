//
//  SecondExampleViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/22.
//

import UIKit

class SecondExampleViewController: UIViewController {
    
    let nameLabel = makeLabel(text: "neenee", size: 20)
    let messageLabel = makeLabel(text: "배고파용", size: 14)
    let xButton = makeButton(image: UIImage(systemName: "xmark"), title: "")
    let giftButton = makeButton(image: UIImage(systemName: "gift"), title: "")
    let qrButton = makeButton(image: UIImage(systemName: "qrcode"), title: "")
    let cameraButton = makeButton(image: UIImage(systemName: "camera"), title: "")
    let chattingButton = makeButton(image: UIImage(systemName: "bubble.left.fill"), title: "나와의 채팅")
    let profilButton = makeButton(image: UIImage(systemName: "pencil"), title: "프로필 편집")
    let storyButton = makeButton(image: UIImage(systemName: "ellipsis.rectangle"), title: "카카오스토리")
    
    var bgImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "bgImage")
        return view
    }()
    
    var profileImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
                view.image = UIImage(named: "testImage")
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    let filterView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.3
        return view
    }()
    
    
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

extension SecondExampleViewController {
    
    static func makeButton(image: UIImage?, title: String) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        if title.isEmpty {
            button.layer.cornerRadius = 15
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
        } else {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .top
            button.backgroundColor = .clear
            configuration.imagePadding = 15
            var attributedTitle = AttributedString(title)
            attributedTitle.font = .preferredFont(forTextStyle: .caption2)
            configuration.attributedTitle = attributedTitle
            button.configuration = configuration
        }
        button.tintColor = .white
        return button
        
    }
    
    
    static func makeAttributedString(text: String) -> NSMutableAttributedString {
        let fontSize = UIFont.boldSystemFont(ofSize: 13)
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: fontSize, range: (text as NSString).range(of: text))
        return attributedStr
    }
    
    static func makeLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: size)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
}
