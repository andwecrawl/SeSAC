//
//  SceneDelegate.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = UITabBarController()
      
        guard let firstVC = sb.instantiateViewController(withIdentifier: MovieCollectionViewController.identifier) as? MovieCollectionViewController else { return }
        let firstNav = UINavigationController(rootViewController: firstVC)
        firstNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        guard let secondVC = sb.instantiateViewController(withIdentifier: ExploreTableViewController.identifier) as? ExploreTableViewController else { return }
        let secondNav = UINavigationController(rootViewController: secondVC)
        secondNav.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "lasso.and.sparkles"), tag: 1)
        
        let thirdVC = WormViewController()
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        thirdNav.tabBarItem = UITabBarItem(title: "Book", image: UIImage(systemName: "bookmark.circle.fill"), tag: 2)
        
        guard let fourthVC = sb.instantiateViewController(withIdentifier: MoreViewController.identifier) as? MoreViewController else { return }
        let fourthNav = UINavigationController(rootViewController: fourthVC)
        fourthNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "plus.magnifyingglass"), tag: 3)
        
        tabBarController.setViewControllers([firstNav, secondNav, thirdNav, fourthNav], animated: false)
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
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

