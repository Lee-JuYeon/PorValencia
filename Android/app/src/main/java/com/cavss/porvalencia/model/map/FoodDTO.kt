package com.cavss.porvalencia.model.map

data class FoodDTO(
    val id: String,
    val name: String,
    val latitude: Double,
    val longitude: Double,
    val mealType: String,    // 제공되는 식사 종류 (아침, 점심, 저녁)
    val openHours: String    // 운영 시간
)