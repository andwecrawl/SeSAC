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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = sb.instantiateViewController(withIdentifier: "mainTabBarController") as? UITabBarController else {
            fatalError("탭바 컨트롤러를 가져올 수 없습니다.")
        }
        
        guard let firstVC = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as? TrendViewController else { return }
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        guard let secondVC = sb.instantiateViewController(withIdentifier: RecommendationViewController.identifier) as? RecommendationViewController else { return }
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        guard let thirdVC = sb.instantiateViewController(withIdentifier: TheaterViewController.identifier) as? TheaterViewController else { return }
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        tabBarController.viewControllers = [firstNav, secondNav, thirdNav]
        
        SceneDelegate.window?.rootViewController = tabBarController
        SceneDelegate.window?.makeKeyAndVisible()
    }
    
    
    func setupLayout() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}
