//
//  ChartView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI

struct ChartView: View {
    
    var chartData: [ChartModel]
    
    // 두 개의 컬럼을 가진 레이아웃 설정 (왼쪽: 제목, 오른쪽: 값)
    private let columns = [
        GridItem(.fixed(100), alignment: .leading), // 제목 컬럼 고정 너비
        GridItem(.flexible(), alignment: .leading)  // 값 컬럼 가변 너비
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(chartData, id: \.title) { item in
                Text(item.title) // 제목
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                
                Text(item.value) // 값
                    .font(.system(size: 20, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(10)
                    .minimumScaleFactor(0.7)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

