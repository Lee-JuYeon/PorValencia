//
//  FoodModel.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/15/24.
//

import SwiftUI

struct FoodModel: Hashable {
    var uid : String
    var title : String
    var address : String
    var lon : Double
    var lat : Double
    var foods : [String]
    var mealType : MealType // 제공되는 식사 종류 (아침, 점심, 저녁)
    var openTime : String // 오픈시간
    var closeTime : String // 마감시간
    var maxPortion : Int // 예상된 전체 식사인원수
    var currentPortion : Int // 현재 식사인원수
}
