//
//  MissingModel.swift
//  PorPorCure
//
//  Created by Jupond on 12/24/24.
//

import Foundation

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

