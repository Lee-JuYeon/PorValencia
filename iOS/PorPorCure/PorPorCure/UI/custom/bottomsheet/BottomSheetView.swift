//
//  MissingSheetView.swift
//  PorPorCure
//
//  Created by Jupond on 1/2/25.
//

import UIKit

class BottomSheetView: UIView {
    private let sheetView = UIView()
    private let grabberView = UIView()
    private var contentView: UIView
    
    var dismissHandler: (() -> Void)? // Bottom Sheet 종료 핸들러
    
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Sheet View 설정
        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 16
        sheetView.clipsToBounds = true
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sheetView)
        
        // Grabber View 설정
        grabberView.backgroundColor = .lightGray
        grabberView.layer.cornerRadius = 3
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(grabberView)
        
        // Content View 추가
        contentView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(contentView)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            sheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            grabberView.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 8),
            grabberView.centerXAnchor.constraint(equalTo: sheetView.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            grabberView.heightAnchor.constraint(equalToConstant: 6),
            
            contentView.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor)
        ])
        
        // 제스처 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sheetView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 { // 아래로만 이동
                sheetView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 150 || velocity.y > 1000 {
                dismissBottomSheet()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.sheetView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    func presentInKeyWindow() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        keyWindow.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: keyWindow.topAnchor),
            leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
            trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
            bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
        ])
        
        // 등장 애니메이션
        sheetView.transform = CGAffineTransform(translationX: 0, y: 300)
        UIView.animate(withDuration: 0.3) {
            self.sheetView.transform = .identity
        }
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sheetView.transform = CGAffineTransform(translationX: 0, y: 300)
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.dismissHandler?()
        }
    }
}
