package com.cavss.porvalencia.model.missing

import com.cavss.porvalencia.type.MissingType
import java.util.Date

data class MissingDTO (
    val uid : String,
    val name : String,
    val imageURL : String,
    val date : Date,
    val location : String,
    val gender : String,
    val character : String,
    val state : MissingType = MissingType.MISSING
){
}




