//
//  DetailVolunteer.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct DetailVolunteer: View {
    
    private var getModel : VolunteerModel
    init(
        setVolunteerModel : VolunteerModel
    ){
        self.getModel = setVolunteerModel
    }

    private let dummyImage = "https://images.khan.co.kr/article/2024/05/09/news-p.v1.20240509.c1f809d53b0240059d214dd19618a23c_P1.png"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("구호단체 이름")
            Text("구호단체 필요조건")
            Text("구호단체 담당지역")

            HStack(alignment: .center){
                AsyncImage(url: URL(string: dummyImage)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // 로딩 중에 표시할 UI
                    case .success(let image):
                        image // 성공 시 받아온 이미지 표시
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        Image(systemName: "xmark.circle") // 실패 시 표시할 UI
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 200)
                .background(Color.gray.opacity(0.2))
                
                
                VStack(alignment:.leading){
                    Text("my name is arroz con leche")
                    Text("sm")
                }
            }
            /*
             구호단체 목적
             구호단체 필요조건
             구호단체 담당지역
             
             프사, 사람이름
             contact.
             */
        }
    }
}
