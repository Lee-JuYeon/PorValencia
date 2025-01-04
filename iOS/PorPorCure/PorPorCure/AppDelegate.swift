//
//  AppDelegate.swift
//  PorPorCure
//
//  Created by Jupond on 12/23/24.
//

import UIKit
import FirebaseCore

/*
 iOS 13 이상에서도 AppDelegate의 application(_:didFinishLaunchingWithOptions:) 메서드는 항상 호출됩니다.
 SceneDelegate는 UI와 관련된 작업을 담당하고, 앱 전반적인 초기화 작업(예: Firebase 초기화)은 여전히 AppDelegate에서 수행됩니다.
 
 */

@UIApplicationMain  // iOS 12에서는 @main 대신 @UIApplicationMain 사용
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?  // iOS 12에서 필요한 window 속성
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // iOS 12에서 window 설정
//        // vc 코드 구현버전
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = MainViewController()
//        window?.makeKeyAndVisible()
        
        // Firebase 초기화
//        if FirebaseApp.app() == nil { // 이미 초기화되었는지 확인
//            FirebaseApp.configure()
//        }
        FirebaseApp.configure()

        // iOS 12 버전에서만 실행
        if #available(iOS 13.0, *) {
            // SceneDelegate가 처리하므로 window 설정 생략
        } else {
            // 스토리보드에서 ViewController 가져오기
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            
            window?.rootViewController = mainViewController
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    // Scene Delegate 관련 메서드들은 iOS 13 이상에서만 사용되므로 조건부 구현
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

