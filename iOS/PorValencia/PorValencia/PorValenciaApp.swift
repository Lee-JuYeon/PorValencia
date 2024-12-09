//
//  PorValenciaApp.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
@main
struct PorValenciaApp: App {
    @StateObject private var screenVM = ScreenVM()
    @StateObject private var missingVM = MissingVM(repository: MissingRepository())
    @StateObject private var mapVM = MapVM(
        mapRepository: MapRepository(), missingRepository: MissingRepository()
        
    )

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(screenVM)
                .environmentObject(missingVM)
                .environmentObject(mapVM)
        }
    }
}
