//
//  Routeview.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI

struct RouteModel : Hashable {
    var uid : String
    var title : String
    var address : String
    var paths : [PathModel]
}

