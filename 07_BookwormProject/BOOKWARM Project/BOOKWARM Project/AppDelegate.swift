//
//  AppDelegate.swift
//  BOOKWARM Project
//
//  Created by yeoni on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } // memo column 추가
            
            if oldSchemaVersion < 2 { // authors -> author
                migration.renameProperty(onType: BookTable.className(), from: "authors", to: "author")
            }
            
            if oldSchemaVersion < 3 { // bookDescription 추가
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let oldObject else { return }
                    guard let newObject else { return }
                    
                    newObject["bookDescription"] = "\(String(describing: oldObject["author"])) · \(String(describing: oldObject["publisher"])) · \(String(describing: oldObject["price"]))"
                }
            }
            
            if oldSchemaVersion < 4 { // price(Int) -> String
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let oldObject else { return }
                    guard let newObject else { return }
                }
            }
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

