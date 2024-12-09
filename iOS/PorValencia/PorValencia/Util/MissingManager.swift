//
//  DateManager.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI


final class MissingManager {
    // 싱글톤 인스턴스
    static let shared = MissingManager()
    
    func getDateByString(setDate: Date?) -> String {
        guard let date = setDate else {
            return "실종당시 날짜를 확인할 수 없음"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // 원하는 날짜 형식
        
        return dateFormatter.string(from: date)
    }

    
    func getMissingState(setType : MissingType?) -> String {
        switch setType {
        case .ALIVE:
            return "생존 확인 완료"
        case .DEAD:
            return "신원 확인 완료"
        case .MISSING:
            return "수색중"
            
        case .none:
            return "확인되지 못하고 있는 상태"
        }
    }

    
    // private init을 통해 인스턴스화 방지
    private init() {}
}
