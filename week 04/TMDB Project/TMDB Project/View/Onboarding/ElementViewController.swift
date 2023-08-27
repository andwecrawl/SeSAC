//
//  ElementViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/27.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
    
}

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
    }
    
}

class ThirdiewController: UIViewController {
    
    let button = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.tintColor = .white
        let config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("확인했어요!")
        attributedTitle.font = .preferredFont(forTextStyle: .title2)
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupLayout()
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let SceneDelegate = windowScene?.delegate as? SceneDelegate else { return }
        
        UserDefaultsHelper.shared.haveBeenBefore = true
        let vc = TrendViewController()
        SceneDelegate.window?.rootViewController = vc
        SceneDelegate.window?.makeKeyAndVisible()
    }
    
    
    func setupLayout() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}
