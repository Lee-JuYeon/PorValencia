//
//  MissingModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct MissingModel: Hashable {
    var uid : String
    var requestFamilyUID : String? = nil
    var missingState : MissingType = MissingType.MISSING
    var name : String
    var date : Date
    var zone : String
    var imageURL : String
    var gender : GenderType
    var character : String
    var lon : Double
    var lat : Double
}

