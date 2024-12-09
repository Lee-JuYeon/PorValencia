//
//  VolunteerModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/10/24.
//

import SwiftUI

struct VolunteerModel : Hashable {
    var uid : String
    var title : String
    var purpose : String
    var requirement : String
    var leaderUID : String
    var maxPeople : Int
    var zone : String
    var joinedPeoples : [String] // people uid
}
