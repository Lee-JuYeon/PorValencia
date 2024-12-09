//
//  HospitalModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/14/24.
//

import SwiftUI

struct HospitalModel: Hashable {
    var uid : String
    var hospitalTitle : String
    var hospitalAddress : String
    var hospitalLon : Double
    var hospitalLat : Double
    var maxBed: Int?
    var currentBed : Int?
    var call : String
}

