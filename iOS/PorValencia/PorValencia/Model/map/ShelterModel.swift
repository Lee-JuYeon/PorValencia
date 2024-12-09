//
//  ShelterModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/15/24.
//

import SwiftUI

struct ShelterModel: Hashable {
    var uid : String
    var title : String
    var address : String
    var lon : Double
    var lat : Double
    var maxBed : Int
    var currentBed : Int
    var isEnterable : Bool
    var call : String
}
