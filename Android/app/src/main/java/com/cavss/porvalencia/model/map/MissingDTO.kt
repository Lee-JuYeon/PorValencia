package com.cavss.porvalencia.model.map

import com.cavss.porvalencia.type.MissingType
import java.util.Date

data class MissingDTO (
    var uid : String,
    var name : String,
    var imageURL : String,
    var date : Date,
    var location : String,
    var gender : String,
    var character : String,
    var state : MissingType = MissingType.MISSING,
    var lat : Double?,
    var lon : Double?
){
}




