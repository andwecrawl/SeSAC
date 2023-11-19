//
//  SceneDelegate.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        UserDefaultsHelper.shared.haveBeenBefore = false
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if UserDefaultsHelper.shared.haveBeenBefore {
            // 처음이 아닐 때
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            guard let tabBarController = sb.instantiateViewController(withIdentifier: "mainTabBarController") as? UITabBarController else {
                fatalError("탭바 컨트롤러를 가져올 수 없습니다.")
            }
            
            let firstNav = UINavigationController(rootViewController: TrendViewController())
            firstNav.tabBarItem = UITabBarItem(title: "Today's Trend", image: UIImage(systemName: "sparkles.tv.fill"), selectedImage: UIImage(systemName: "sparkles.tv.fill"))
            
            guard let secondVC = sb.instantiateViewController(withIdentifier: RecommendationViewController.identifier) as? RecommendationViewController else { return }
            let secondNav = UINavigationController(rootViewController: secondVC)
            secondNav.tabBarItem = UITabBarItem(title: "Recommendation", image: UIImage(systemName: "magnifyingglass.circle.fill"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
            
            guard let thirdVC = sb.instantiateViewController(withIdentifier: TheaterViewController.identifier) as? TheaterViewController else { return }
            let thirdNav = UINavigationController(rootViewController: thirdVC)
            
            let fourthVC = ProfileViewController()
            let fourthNav = UINavigationController(rootViewController: fourthVC)
            fourthNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
            
            tabBarController.viewControllers = [firstNav, secondNav, thirdNav, fourthNav]
            
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        } else {
            let vc = OnboardingViewController()
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

