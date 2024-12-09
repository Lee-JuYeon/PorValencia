//
//  MissingView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI


struct MissingView: View {
    
    @EnvironmentObject private var missingVM : MissingVM
    @Environment(\.colorScheme) private var scheme
    
    @State private var isShowBottomSheet = false

    @State private var sheetContactView = false
    private func topView() -> some View {
        return HStack(alignment:.center){
            Spacer()
            Image("image_bell")
                .resizable()
                .frame(
                    width: 40,
                    height: 40
                )
                .onTapGesture {
                    sheetContactView.toggle()
                }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }
    

    private let columns = [
        GridItem(.flexible()), // 첫 번째 열
        GridItem(.flexible())  // 두 번째 열
    ]
    
    
    private var chartList : [ChartModel] {
        var data: [ChartModel] = [
            ChartModel(title: "이름", value: missingVM.currentMissingModel?.name ?? "")
        ]
        
        // 성별
        if let gender = missingVM.currentMissingModel?.gender.rawValue {
            data.append(ChartModel(title: "성별", value: gender))
        }
        
        // 실종상태
        data.append(ChartModel(title: "실종 현황", value: MissingManager.shared.getMissingState(setType: missingVM.currentMissingModel?.missingState)))

        // 실종날짜
        data.append(ChartModel(title: "실종 날짜", value: MissingManager.shared.getDateByString(setDate: missingVM.currentMissingModel?.date)))
        
        // 실종 위치
        if let missingPlace = missingVM.currentMissingModel?.zone {
            data.append(ChartModel(title: "실종 위치", value: missingPlace))
        }
        
        // 외관 특징
        if let character = missingVM.currentMissingModel?.character {
            data.append(ChartModel(title: "외관상 특징", value: character))
        }
        
        return data
    }
    
    var body: some View {
        VStack(alignment: .leading){
            topView()
            
            NeumorphismView(
                setMainColour: Color.mainColour,
                setLeftShadowColour: Color("leftShadowColour"),
                setRightShadowColour: Color("rightShadowColour"),
                setOnClick: {
                    
                }
            ) {
                    TextField(missingVM.missingSearchHint, text: $missingVM.missingSearchText)
                        .onChange(of: missingVM.missingSearchText) { newValue in
                            missingVM.searchMissingPeople(name: newValue)
                        }
                        .padding(.all, 8)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 20))
                        .foregroundColor(scheme == .dark ? .white : .black)
                        .padding(.all, 4)
                }
                .padding(.all, 10)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 80,
                    maxHeight: 80
                )
          
                
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(missingVM.editableMissingList, id: \.self) { model in
                        MissingCell(
                            setModel: model,
                            setOnClick: { missingModel in
                                isShowBottomSheet.toggle()
                                missingVM.updateCurrentModel(model: missingModel)
                            }
                        )
                    }
                }
            }
        }
        .background(Color("mainColour"))
        .sheet(isPresented: $sheetContactView) {
           ContactView()
        }
        .sheet(
            isPresented: $isShowBottomSheet,
            onDismiss: {
                isShowBottomSheet = false
            },
            content: {
                BottomSheetView(content: {
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: missingVM.currentMissingModel?.imageURL ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "xmark.circle")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        
                        ChartView(chartData: chartList)
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                })
            }
        )
    }
}

