//
//  MapChipsView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI

struct MapChipsModel : Hashable {
    var uid : String
    var image : String
    var englishTitle : String
    var localTitle : String
}

struct MapChipsView: View {
    
    private var getMapChips : [MapChipsModel]
    private var getOnClick : (MapChipsModel) -> ()
    init(
        setMapChips : [MapChipsModel],
        setOnClick : @escaping (MapChipsModel) -> ()
    ){
        self.getMapChips = setMapChips
        self.getOnClick = setOnClick
    }
    
    
    @State private var selectedChips: Set<MapChipsModel> = []
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .center) {
                ForEach(getMapChips, id: \.self) { model in
                    NeumorphismView(
                        setMainColour: Color.mainColour,
                        setLeftShadowColour: Color("leftShadowColour"),
                        setRightShadowColour: Color("rightShadowColour"),
                        setOnClick: {
                            getOnClick(model)
                            if selectedChips.contains(model) {
                                selectedChips.remove(model)
                            } else {
                                selectedChips.insert(model)
                            }
                        }
                    ) {
                        HStack {
                            Image(model.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            Text(model.localTitle)
                        }
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                }
            }
        }
        .background(Color("mainColour"))
        .frame(
            height: 80,
            alignment: .center
        )
    }
}

