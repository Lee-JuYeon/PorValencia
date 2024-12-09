//
//  ChipItem.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI

struct ChipItem: View {
    var chipText: String
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        Text(chipText)
            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
            .lineLimit(1)
            .background(isSelected ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .onTapGesture {
                onTap()
            }
    }
}

