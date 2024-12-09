package com.cavss.porvalencia.model.map

data class HospitalDTO(
    var id: String,
    var title: String,
    var address : String,
    var latitude: Double,
    var longitude: Double,
    var maxBed: Int?, // 응급 환자 수용 가능 인원
    var currentBed : Int?, //현재 병상 차지하는
    var call: String     // 연락처 정보
)