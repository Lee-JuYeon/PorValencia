//
//  MainScreen.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct MainScreen: View {
    
//    @ObservedObject private var mapVM : MapVM

  
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color("mainColour")) // 탭 바의 배경색을 검은색으로 설정
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray // 선택되지 않은 아이템 색상(옵션)
        UITabBar.appearance().barTintColor = UIColor(Color("mainColour")) // iOS 15 이하에서의 호환성 설정
        UITabBar.appearance().tintColor = UIColor(Color.blue) // 선택된 탭 아이템 색상

    }
    

    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(uiImage: UIImage(named: "image_point")!)
                    Text(String(localized: "지도"))
                }

            NotifictionView()
                .tabItem {
                    Image(uiImage: UIImage(named: "image_bell")!)
                    Text(String(localized: "소식"))
                }
//            MissingView()
//                .tabItem {
//                    Image(uiImage: UIImage(named: "image_missing")!)
//                    Text("Missing")
//                }
        }   
    }
}
