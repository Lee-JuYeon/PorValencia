//
//  Gender.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

enum GenderType: String {
    case MALE = "MALE"
    case FEMALE = "FEMALE"
    
    // 서버 값 변환 메서드 추가
       static func fromServerValue(_ value: String) -> GenderType? {
           switch value.uppercased() {
           case "MALE":
               return .MALE
           case "FEMALE":
               return .FEMALE
           default:
               return .MALE
           }
       }
}
