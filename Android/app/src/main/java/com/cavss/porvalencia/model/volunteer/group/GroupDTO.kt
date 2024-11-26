package com.cavss.porvalencia.model.volunteer.group

data class GroupDTO(
    var uid : String,
    var title : String,
    var limitPeople : Int,
    var currentPeople : Int,
    var purpose : String,
    var requirement : String
) {
}