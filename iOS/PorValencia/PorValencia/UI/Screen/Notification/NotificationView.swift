//
//  NotificationView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 12/1/24.
//

import SwiftUI

struct NotifictionView : View {
    
    @EnvironmentObject var missingVM : MissingVM
    
    func notificationTitle() -> some View {
        return HStack(alignment: .center){
            Text("📣")
                .font(.title)
            
            GradientText(
                text: String(localized: "소식"),
                gradientColors: [Color.cyan, Color.yellow, Color.blue]
            )
            .font(.title)
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
    }
   
    
    var body: some View {
        // 스크롤 가능 영역
        VStack(alignment: .leading, spacing: 16) {
            ContactView()
            
            VStack(alignment: .leading){
                notificationTitle()
               
                ScrollView(Axis.Set.vertical) {
                    LazyVStack(alignment: .leading, spacing: 5) { // LazyVStack 자체를 왼쪽 정렬
                        ForEach(missingVM.notificationList, id: \.uid) { model in
                           NotificationCell(model: model)
                        }
                    }
                }

            }
        }
        .background(Color("mainColour"))
    }
}
