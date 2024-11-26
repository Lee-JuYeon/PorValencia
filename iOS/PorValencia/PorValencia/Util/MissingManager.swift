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
    
    func getDateByString(setDate : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // 원하는 날짜 형식
        
        // 날짜를 문자열로 변환
        let dateString = dateFormatter.string(from: setDate)
        return dateString
    }
    
    
    // private init을 통해 인스턴스화 방지
    private init() {}
}
