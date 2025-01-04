//
//  Screen.swift
//  PorPorCure
//
//  Created by Jupond on 1/2/25.
//

import UIKit

class Screen {
    
    // 싱글톤 인스턴스
    static let size = Screen()
    
    let width: CGFloat = {
        if #available(iOS 16.0, *) {
            // iOS 13 이상에서 UIWindowScene을 통해 화면 너비 가져오기
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.screen.bounds.width
            }
        }
        // iOS 13 미만에서는 UIScreen 사용
        return UIScreen.main.bounds.width
    }()
    
    
    let height: CGFloat = {
        if #available(iOS 16.0, *) {
            // iOS 13 이상에서 UIWindowScene을 통해 화면 너비 가져오기
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.screen.bounds.height
            }
        }
        // iOS 13 미만에서는 UIScreen 사용
        return UIScreen.main.bounds.height
    }()
    
}
