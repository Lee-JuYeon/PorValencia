package com.cavss.porvalencia.model.map

data class HospitalDTO(
    val id: String,
    val name: String,
    val latitude: Double,
    val longitude: Double,
    val emergencyCapacity: Int, // 응급 환자 수용 가능 인원
    val contactInfo: String     // 연락처 정보
)