package com.cavss.porvalencia.model.map

data class BedDTO(
    val id: String,
    val name: String,
    val latitude: Double,
    val longitude: Double,
    val capacity: Int,      // 수용 가능한 인원수
    val contactInfo: String // 연락처 정보
)