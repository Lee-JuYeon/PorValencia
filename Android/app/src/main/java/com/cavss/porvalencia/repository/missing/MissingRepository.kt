package com.cavss.porvalencia.repository.missing

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cavss.porvalencia.model.missing.MissingDTO
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.type.GenderType
import java.util.Date

class MissingRepository {

    suspend fun getMissingList() : List<MissingDTO>{
        val dummyList = listOf(
            MissingDTO(uid = "uid1", name = "Yassine Sadiqi", imageURL = "https://pbs.twimg.com/media/GbuqCh2WwBUjIPZ?format=jpg&name=large", date = Date(), location = "Alfafar Plaza vieja del parque Alcosa", gender = GenderType.MALE.rawValue, character = "67 anos, 1,75, complexion corpulenta, pelo blanco, ojo verdosos, narzi y orejas prominentes, verrugas en pecho, cabeza y oreja derecha"),
            MissingDTO(uid = "uid2", name = "Rosa Maria Aquilar Hernandez", imageURL = "https://pbs.twimg.com/media/Gbub5Q7WgAsWpHj?format=jpg&name=small", date = Date(), location = "Vera Almeria", gender = GenderType.MALE.rawValue, character = "15 anos complexion delegada, pelo rubio tenido y ondulado, ojos negros, hoyuelo en menton"),
            MissingDTO(uid = "uid3", name = "Fernando Duran Nunez", imageURL = "https://pbs.twimg.com/media/GbtM0BTXEAURW8g?format=jpg&name=small", date = Date(), location = "Vera Almeria", gender = GenderType.MALE.rawValue, character = "complexion media, estatura media, pelirrojo, ojos azules, calvicie parcial"),
            MissingDTO(uid = "uid4", name = "Jose C. R", imageURL = "https://pbs.twimg.com/media/GbtBQB3XIAMcUew?format=jpg&name=small", date = Date(), location = "Catarroja valencia", gender = GenderType.FEMALE.rawValue, character = "35 anos, complexio delgada, pelo marron, ojos negros"),
            MissingDTO(uid = "uid5", name = "Lorenza Marlene Villaverde", imageURL = "https://pbs.twimg.com/media/Gbs5tdvXsAkDOMn?format=jpg&name=small", date = Date(), location = "La Rinconada Sevilla", gender = GenderType.MALE.rawValue, character = "66 anos,170 estatura, complexsion gruesa, pelo nego y ondulado, ojos marrones, gafas graduadas"),
            MissingDTO(uid = "uid6", name = "Javi Sanchez Rocafull", imageURL = "https://pbs.twimg.com/media/Gbs2zttWYBEohUC?format=jpg&name=small", date = Date(), location = "Benetusser VAlencia", gender = GenderType.MALE.rawValue, character = "54 anos, complexion normal, pelo castano, ojos marrones, gafas graduadas, cadena con una cruz"),
            MissingDTO(uid = "uid7", name = "Israel Salinas Fernandez", imageURL = "https://pbs.twimg.com/media/Gbsn5ZLW8BgjQfa?format=jpg&name=small", date = Date(), location = "San Cristobal de la Laguna Santa Cruz de Tenerife", gender = GenderType.FEMALE.rawValue, character = "55 anos, 155 estatura, complexion gruesa, pelo castano claro, ojos marrones, pequeno corte")
        )
        return dummyList
    }
}