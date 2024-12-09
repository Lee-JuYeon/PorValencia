//
//  VolunteerCell.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/10/24.
//

import SwiftUI

struct VolunteerCell : View {
    
    private var getModel : VolunteerModel
    init(
        setModel : VolunteerModel
    ){
        self.getModel = setModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 5
        ){
            Text(getModel.title)
                .lineLimit(2) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 최소 50%까지 축소
                .font(.system(size: 20, weight: Font.Weight.bold))
                
            Text("🎯 \(getModel.purpose)")
                .lineLimit(2) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 최소 50%까지 축소
                .font(.system(size: 18, weight: Font.Weight.medium))
            
            Text("📍 \(getModel.zone)")
                .lineLimit(2) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 최소 50%까지 축소
                .font(.system(size: 15, weight: Font.Weight.medium))
            
            Text("👤 \(getModel.joinedPeoples.count) / \(getModel.maxPeople)")
                .lineLimit(1) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 최소 50%까지 축소
                .font(.system(size: 15, weight: Font.Weight.medium))
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)  // 회색 테두리와 둥근 모서리
        })
        .onTapGesture {
            
        }
    }
}

