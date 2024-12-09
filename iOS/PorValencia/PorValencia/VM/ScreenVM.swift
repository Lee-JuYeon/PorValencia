//
//  ScreenVM.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI

class ScreenVM: ObservableObject {
    
    enum SheetType {
        case GodLifeCell
    }
    
    enum ScreenType {
        case MainView
    }
    
    @Published var pageIndex : Int = 0
    
}
