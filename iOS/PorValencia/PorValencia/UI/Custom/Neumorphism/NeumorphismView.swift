//
//  Neumorphism.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI

struct NeumorphismView<GetView : View> : View {
    
    private var getView : () -> GetView
    private var getMainColour : Color
    private var getLeftShadowColour : Color
    private var getRightShadowColour : Color
    private var getOnClick : () -> ()
    
    @Environment(\.colorScheme) private var scheme

    enum AnimationType {
        case OVER
        case HOLE
    }
    
    @State private var getAnimateType : AnimationType = AnimationType.OVER
    
    init(
        setMainColour : Color,
        setLeftShadowColour : Color,
        setRightShadowColour : Color,
        setOnClick : @escaping () -> (),
        @ViewBuilder content : @escaping () -> GetView
    ) {
            
        self.getView = content
        self.getMainColour = setMainColour
        self.getLeftShadowColour = setLeftShadowColour
        self.getRightShadowColour = setRightShadowColour
        self.getOnClick = setOnClick
    }
    
    var body : some View {
        VStack(content: getView)
            .background(
                ZStack{
                    getMainColour
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 10
                            )
                            .stroke(scheme == .dark ? .black : .white, lineWidth: getAnimateType == .OVER ? 1 : 0)
                        }
                
                    if(getAnimateType == .HOLE){
                        RoundedRectangle(
                            cornerRadius: 10, style: .continuous
                        ).fill(
                            LinearGradient(
                                gradient : Gradient(
                                    colors : [
                                        getRightShadowColour,
                                        getLeftShadowColour
                                    ]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .padding(.all, getAnimateType == .OVER ? 1 : 0)
                    }
                   
                }
            )
            .clipShape(RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            ))
            .shadow( // 우하단
                color: getAnimateType == .OVER ? getRightShadowColour : Color.clear,
                radius: 5, x: 5, y: 5)
            .shadow( // 좌상단
                color: getAnimateType == .OVER ? getLeftShadowColour : Color.clear,
                radius: 5, x: -5, y: -5)
            .padding(.all, 5)
            .onTapGesture {
//                if (getAnimateType == .OVER){
//                    getAnimateType = .HOLE
//                }else{
//                    getAnimateType = .OVER
//                }
                getOnClick()
            }
    }
}


