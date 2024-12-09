//
//  GradientText.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/11/24.
//

import SwiftUI

struct GradientText: View {
    var text: String
    var gradientColors: [Color]
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.clear) // 텍스트 색상을 투명하게 설정
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(
                    Text(text)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                )
            )
    }
}
