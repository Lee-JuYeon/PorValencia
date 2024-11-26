//
//  NotificationView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct ContactView: View {
    
    var body: some View {
        BottomSheetView {
            VStack(alignment: .leading) {
                HStack(alignment: .center){
                    Image("AppIcon")
                    GradientText(text: "Contact", gradientColors: [Color.cyan, Color.yellow, Color.blue])

                }
                
                EmailView(email: "redpond2@naver.com")
                Xview(id: "@por_valencia_")
                InstaView(id: "@por_valencia_")
           
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .leading
            )
            .padding(10)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
