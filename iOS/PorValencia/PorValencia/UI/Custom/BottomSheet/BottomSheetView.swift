//
//  BottomSheetView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI
import UIKit

struct BottomSheetView<Content: View>: UIViewControllerRepresentable {
    var contentView: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.contentView = content()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        
        // SwiftUI contentView를 UIHostingController로 감싸서 추가
        let hostingController = UIHostingController(rootView: contentView)
        
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.didMove(toParent: viewController)
        
        // Auto Layout 제약 조건
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
        
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // 시트 크기 조정
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
