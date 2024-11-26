package com.cavss.porvalencia.model.map

import android.graphics.drawable.Drawable

data class TagDTO(
    var uid : String,
    var englishTitle : String,
    var localTitle : Int,
    var drawableImage : Drawable
) {
}