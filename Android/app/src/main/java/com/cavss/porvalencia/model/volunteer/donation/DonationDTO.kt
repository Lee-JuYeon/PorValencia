package com.cavss.porvalencia.model.volunteer.donation

data class DonationDTO(
    var uid : String,
    var giver : String,
    var donation : HashMap<String, Float>
) {
}