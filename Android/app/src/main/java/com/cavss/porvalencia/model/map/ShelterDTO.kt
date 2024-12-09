package com.cavss.porvalencia.model.map

data class ShelterDTO(
    var uid : String,
    var title : String,
    var address : String,
    var lon : Double,
    var lat : Double,
    var maxPeople : Int?,
    var currentPeople : Int?,
    var isEnterable : Boolean,
    var call : String
)