//
//  CustomTabView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI

struct CustomTabView<Content: View>: View {
    
    enum CustomTabViewStyle {
        case BottomNavigation
        case TabView
    }
    
    
    struct CustomTabItemModel : Hashable{
        let image: String
        let title: String
    }
    
    private var getTabItemModels: [CustomTabItemModel]
    private var getTabViewStyle: CustomTabViewStyle
    private var getTabBackgroundColour : Color
    @Binding var getSelectedIndex: Int
    @ViewBuilder private let getContent: (Int) -> Content
    
    @State private var currentTitle : String = ""
    
    init(
        setTabViewStyle: CustomTabViewStyle,
        setTabBackgroundColour : Color,
        setTabItemModels: [CustomTabItemModel],
        setSelectedIndex: Binding<Int>,
        @ViewBuilder setContent: @escaping (Int) -> Content
    ) {
        self.getTabItemModels = setTabItemModels
        self.getTabBackgroundColour = setTabBackgroundColour
        self._getSelectedIndex = setSelectedIndex
        self.getContent = setContent
        self.getTabViewStyle = setTabViewStyle
    }
    
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader{ geo in
            VStack(
                alignment : HorizontalAlignment.center,
                spacing: 0
            ) {
                switch(getTabViewStyle){
                case .BottomNavigation :
                    TabScreenView(geo: geo)
                    TabNavigationView(geo: geo)
                case .TabView :
                    TabNavigationView(geo: geo)
                    TabScreenView(geo: geo)
                }
            }
            .background(.clear)
        }
        
    }
    
    private func TabScreenView(geo : GeometryProxy) -> some View {
        return getContent(getSelectedIndex)
            .frame(
                height: (geo.size.height / 20) * 19
            )
            .onAppear {
                currentTitle = getTabItemModels.first?.title ?? ""
            }
    }
    
    private func TabNavigationView(geo : GeometryProxy) -> some View {
        return VStack(alignment : HorizontalAlignment.center, spacing: 0){
            switch(getTabViewStyle){
            case .BottomNavigation :
                Rectangle()
                    .fill()
                    .background(.black)
                    .frame(
                        width: geo.size.width, // Replace UIScreen with geo.size
                        height: 1
                    )
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(
                        alignment : VerticalAlignment.center,
                        spacing: 0,
                        content: {
                            ForEach(getTabItemModels, id: \.self) { model in
                                TabItemView(setModel: model, geo: geo)
                            }
                        }
                    )
                }
            case .TabView :
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(
                        alignment : VerticalAlignment.center,
                        spacing: 0,
                        content: {
                            ForEach(getTabItemModels, id: \.self) { model in
                                TabItemView(setModel: model, geo: geo)
                            }
                        }
                    )
                }
                Rectangle()
                    .fill()
                    .background(.black)
                    .frame(
                        width: geo.size.width, // Replace UIScreen with geo.size
                        height: 1
                    )
            }
        }
        .background(getTabBackgroundColour)
        .frame(
            width: geo.size.width, // Replace UIScreen with geo.size
            height: (geo.size.height / 20) * 1
        )
    }
    
    private func TabItemView(setModel getModel: CustomTabItemModel, geo: GeometryProxy) -> some View {
        return VStack(alignment : HorizontalAlignment.center, spacing: 0){
            Image(getModel.image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(getModel.title == currentTitle ? (scheme == .dark ? Color.white : Color.black) : Color.gray)
            
            Text(getModel.title)
                .foregroundColor(getModel.title == currentTitle ? (scheme == .dark ? Color.white : Color.black) : Color.gray)
                .fontWeight(getModel.title == currentTitle ? .bold : .light)
            
        }
        .onTapGesture {
            currentTitle = getModel.title
            if let index = getTabItemModels.firstIndex( where: { $0.title == getModel.title }) {
                getSelectedIndex = index
            } else {
                getSelectedIndex = 0
            }
        }
        .frame(
            width: geo.size.width / CGFloat(getTabItemModels.count) // Replace UIScreen with geo.size
        )
    }
}
