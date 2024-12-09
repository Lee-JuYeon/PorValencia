//
//  UserModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

struct UserModel : Hashable {
    var uid : String
    var selfieURL : String
    var name : String
    var socialMedia : [String : String]?
    
    let address : String? = nil// 주소
    let lat: Double? = nil// 위도 경도
    let long: Double? = nil// 위도 경도
    let sickness : String? = nil// 아픈 증상 ( 전염병, 보건소 의약품 찾기 )
    let needs : String? = nil// 필요한 구호물품 (생리대, 물 등)
}
