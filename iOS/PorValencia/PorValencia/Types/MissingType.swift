//
//  MissingType.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/12/24.
//

import SwiftUI

enum MissingType {
    case MISSING
    case ALIVE
    case DEAD
    
    // 서버 값 변환 메서드 추가
    static func fromServerValue(_ value: String) -> MissingType? {
        switch value.uppercased() {
        case "MISSING":
            return .MISSING
        case "ALIVE":
            return .ALIVE
        case "DEAD":
            return .DEAD
        default:
            return .MISSING
        }
    }
}
