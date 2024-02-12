//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // 이 코드는 제거할 수 없음....... 여ㅓㅇ영 남는 레거시 코드
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            
            // 개별적인 조건문 만들어 주는 이유 -> if else 문으로 하면 한 버전만 업데이트하고 끝나게 되므로 결국 최종 버전으로 업데이트될 수 없음
            if oldSchemaVersion < 1 { } // pinned Column 추가
            if oldSchemaVersion < 2 { } // pinned column 삭제
            
            // column이 바뀐 경우에는 어떤 column이 어떻게 바뀌어야 하는지를 작성해 주어야 함
            // photoURL -> Photo Column 이름 변경
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: DiaryTable.className(), from: "photoURL", to: "photo")
            }
            
            // contents -> content
            if oldSchemaVersion < 4 {
                // 앱에서 런타임 오류가 발생하지 않는다고 해서 내용 작성을 하지 않으면 안댐!!
                    // 추가 / 제거 외에 아무것도 작성하지 않으면 데이터가 날아간당...
                    // 단순히 추가 / 삭제 외에 뭔가 수정을 하게 된다면 작성해 주어야 함
                    // 생각을 잘 해서 대응해야 함!!
                migration.renameProperty(onType: DiaryTable.className(), from: "contents", to: "content")
            }
            
            if oldSchemaVersion < 5 {
                // diarySummary에 column 추가
                    // 다만 기존의 title / content 활용하여 setting
                
                // 새로운 column을 추가했을 때 뭔가를 추가하게 댐
                migration.enumerateObjects(ofType: DiaryTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    // 기본값을 넣는 거임
                    // 근데 oldObject 값에 (다른 컬럼에 잇는 내용을 활용해서 넣고 십다면?
                    new["diarySummary"] = "제목은 '\(old["title"])'이고, 내용은 '\(old["content"])'입니당"
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

