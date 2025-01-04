//
//  SceneDelegate.swift
//  PorPorCure
//
//  Created by Jupond on 12/23/24.
//

import UIKit

@available(iOS 13.0, *)  // iOS 13 이상에서만 사용 가능하도록 표시
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // VC 코드 구현버전
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)  // 기존 window 프로퍼티에 할당
//        window?.rootViewController = MainViewController()
//        window?.makeKeyAndVisible()
        
        // 스토리보드 버전
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // iOS 13 이상에서 사용되는 메서드
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // AppDelegate의 applicationDidBecomeActive와 동일
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // AppDelegate의 applicationWillResignActive와 동일
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // AppDelegate의 applicationWillEnterForeground와 동일
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // AppDelegate의 applicationDidEnterBackground와 동일
    }
}
