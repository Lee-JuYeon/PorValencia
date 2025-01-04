//
//  GradientTextView.swift
//  PorPorCure
//
//  Created by Jupond on 12/28/24.
//

import UIKit

class GradientTextView: UILabel {
    
    // 그라데이션 레이어
    private let gradientLayer = CAGradientLayer()
    
    // 그라데이션 색상 설정
    var gradientColors: [UIColor] = [] {
        didSet {
            updateGradient()
        }
    }
    
    // 그라데이션 방향 설정 (시작점과 끝점)
    var gradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5) {
        didSet {
            gradientLayer.startPoint = gradientStartPoint
        }
    }
    
    var gradientEndPoint: CGPoint = CGPoint(x: 1.0, y: 0.5) {
        didSet {
            gradientLayer.endPoint = gradientEndPoint
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        // 그라데이션 레이어 설정
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        
        // 레이어 마스크로 텍스트에 그라데이션 적용
        layer.addSublayer(gradientLayer)
        gradientLayer.mask = layer
    }
    
    private func updateGradient() {
        gradientLayer.colors = gradientColors.map { $0.cgColor }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
