//
//  MissingCell.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI

struct MissingCell : View {
    private var model : MissingModel
    private var getOnClick : (MissingModel) -> ()
    init(
        setModel: MissingModel,
        setOnClick: @escaping (MissingModel) -> ()
    ) {
        self.model = setModel
        self.getOnClick = setOnClick
    }
    
    private func showMissingState() -> String {
        return switch(model.missingState){
            case MissingType.ALIVE :
                "생존 확인 완료"
            case MissingType.DEAD :
                "신원 확인 완료"
            case MissingType.MISSING :
                "수색중"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: model.imageURL)) { phase in
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
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 200,
                maxHeight: 200
            )
            
            Text(model.name)
                .lineLimit(2) // 한 줄로 제한
                .minimumScaleFactor(0.7) // 최소 50%까지 축소
                .font(.system(size: 20,weight: Font.Weight.bold))
            
            Text("⏰ \(showMissingState())")
                .font(.system(size: 20,weight: Font.Weight.light))


            Text("📆 \(MissingManager.shared.getDateByString(setDate: model.date))")
                .font(.system(size: 20,weight: Font.Weight.light))
        }
        .onTapGesture {
            getOnClick(model)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 300,
            maxHeight: 300,
            alignment: .top
        )
    }
}
