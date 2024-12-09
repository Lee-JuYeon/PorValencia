package com.cavss.porvalencia.repository.missing

import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.type.GenderType
import java.util.Date

class MissingRepository {

    suspend fun getMissingList() : List<MissingDTO>{
        val dummyList = listOf<MissingDTO>()
        return dummyList
    }
}