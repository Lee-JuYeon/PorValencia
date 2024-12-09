//
//  NotificationView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct ContactView: View {
    
    var body: some View {
//        BottomSheetView {
//            VStack(alignment: .leading) {
//                HStack(alignment: .center){
//                    Image("AppIcon")
//                    GradientText(text: "Contact", gradientColors: [Color.cyan, Color.yellow, Color.blue])
//
//                }
//                
//                EmailView(email: "redpond2@naver.com")
//                Xview(id: "@por_valencia_")
//                InstaView(id: "@por_valencia_")
//           
//            }
//            .frame(
//                minWidth: 0,
//                maxWidth: .infinity,
//                alignment: .leading
//            )
//            .background(Color("mainColour"))
//        }
        VStack(alignment: .leading) {
            GradientText(text: String(localized: "연락"), gradientColors: [Color.cyan, Color.yellow, Color.blue])
            
            EmailView(email: "redpond2@naver.com")
            Xview(id: "@por_valencia_")
            InstaView(id: "@por_valencia_")
       
        }
        .padding(
            EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        )
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(Color("mainColour"))
    }
}
