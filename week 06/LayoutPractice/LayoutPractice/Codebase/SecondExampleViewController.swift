//
//  SecondExampleViewController.swift
//  LayoutPractice
//
//  Created by yeoni on 2023/08/22.
//

import UIKit

class SecondExampleViewController: UIViewController {
    
    let xButton = makeButton(image: UIImage(systemName: "xmark"), title: "")
    let giftButton = makeButton(image: UIImage(systemName: "gift"), title: "")
    let qrButton = makeButton(image: UIImage(systemName: "qrcode"), title: "")
    let cameraButton = makeButton(image: UIImage(systemName: "camera"), title: "")
    
    var bgImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "bgImage")
        return view
    }()
    
    var profileImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        //        view.image = UIImage(named: "testImage")
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    
    let filterView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.3
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setLayout()
    }
    
    
    func setLayout() {
        [giftButton, qrButton, cameraButton].map {
            self.stackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
        }
        [bgImageView, filterView, xButton, giftButton, qrButton, cameraButton, profileImageView, stackView].forEach { element in
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
            make.size.equalTo(30)
            make.leading.equalTo(8)
            make.top.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.trailing.equalTo(-8)
            
        }
        
        
        
    }
}

extension SecondExampleViewController {
    
    static func makeButton(image: UIImage?, title: String) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        if title.isEmpty {
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
        }
        return button
        
    }

}
