package com.cavss.porvalencia.repository.map

import com.cavss.porvalencia.model.map.FoodDTO
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.model.map.ShelterDTO
import com.cavss.porvalencia.type.GenderType
import com.cavss.porvalencia.type.MealType
import java.util.Date


class MapRepository {

    suspend fun getHospitalList(): List<HospitalDTO> {
        val dummyList = listOf(
            HospitalDTO("1", "Valencia Central Hospital", "123 Main Street, Valencia", 39.4702, -0.3768, null, null, "+34 123 456 789"),
            HospitalDTO("2", "Saint Mary's Medical Center", "456 Health Ave, Valencia", 39.4695, -0.3755, 200, null, "+34 987 654 321"),
            HospitalDTO("3", "Valencia General Clinic", "789 Wellness Blvd, Valencia", 39.4721, -0.3771, null, 45, "+34 111 222 333"),
            HospitalDTO("4", "Northern Valencia Hospital", "101 North St, Valencia", 39.4780, -0.3705, 120, null, "+34 444 555 666"),
            HospitalDTO("5", "East Valencia Medical Center", "202 East Blvd, Valencia", 39.4667, -0.3733, null, 70, "+34 555 666 777"),
            HospitalDTO("6", "South Valencia Emergency Care", "303 South Lane, Valencia", 39.4623, -0.3800, 75, 60, "+34 666 777 888"),
            HospitalDTO("7", "University Hospital Valencia", "404 Campus Rd, Valencia", 39.4755, -0.3670, 300, 250, "+34 777 888 999"),
            HospitalDTO("8", "Valencia Pediatric Center", "505 Kids Ave, Valencia", 39.4689, -0.3748, 80, 60, "+34 888 999 000"),
            HospitalDTO("9", "West Valencia Care", "606 West St, Valencia", 39.4712, -0.3811, 100, 85, "+34 999 000 111"),
            HospitalDTO("10", "Central Valencia Trauma Center", "707 Trauma Ln, Valencia", 39.4705, -0.3772, 150, 120, "+34 000 111 222")
        )
        return dummyList
    }


    suspend fun getShelterList(): List<ShelterDTO> {
        val dummyList = listOf(
            ShelterDTO("1", "Valencia Emergency Shelter", "101 Safe Haven Rd, Valencia", -0.3767, 39.4699, null, null, true, "+34 444 555 666"),
            ShelterDTO("2", "Central Valencia Shelter", "202 Refuge Ln, Valencia", -0.3754, 39.4688, 80, null, false, "+34 777 888 999"),
            ShelterDTO("3", "Northern Valencia Haven", "303 Protection Pl, Valencia", -0.3749, 39.4715, 120, 100, true, "+34 222 333 444"),
            ShelterDTO("4", "South Valencia Refuge", "404 Safe Blvd, Valencia", -0.3790, 39.4620, null, null, true, "+34 555 666 777"),
            ShelterDTO("5", "East Valencia Shelter", "505 Shelter St, Valencia", -0.3725, 39.4665, 200, null, true, "+34 666 777 888"),
            ShelterDTO("6", "Valencia Family Shelter", "606 Family Ln, Valencia", -0.3775, 39.4700, null, 100, false, "+34 333 444 555"),
            ShelterDTO("7", "University Safe Haven", "707 Campus Rd, Valencia", -0.3678, 39.4745, 300, 250, true, "+34 888 999 000"),
            ShelterDTO("8", "West Valencia Shelter", "808 West Rd, Valencia", -0.3820, 39.4710, 150, 120, true, "+34 111 222 333"),
            ShelterDTO("9", "Central Park Refuge", "909 Park Ave, Valencia", -0.3745, 39.4690, 100, null, true, "+34 000 111 222"),
            ShelterDTO("10", "Harbor View Shelter", "1010 Harbor Rd, Valencia", -0.3701, 39.4760, 80, 75, false, "+34 555 666 777")
        )
        return dummyList
    }


    suspend fun getFoodList(): List<FoodDTO> {
        val dummyList = listOf(
            FoodDTO("1", "Valencia Free Meal Center", "123 Food Plaza, Valencia", 39.4697, -0.3765, listOf("Soup", "Bread", "Salad"), MealType.LUNCH, "11:00 AM", "2:00 PM", 300, 200),
            FoodDTO("2", "Community Kitchen", "456 Dinner St, Valencia", 39.4689, -0.3748, listOf("Rice", "Vegetables", "Chicken"), MealType.DINNER, "6:00 PM", "9:00 PM", 200, 150),
            FoodDTO("3", "Morning Meal Hub", "789 Sunrise Ave, Valencia", 39.4705, -0.3772, listOf("Coffee", "Pancakes", "Fruit"), MealType.BREAKFAST, "7:00 AM", "10:00 AM", 100, 90),
            FoodDTO("4", "Valencia Soup Kitchen", "1010 Warm St, Valencia", 39.4680, -0.3750, listOf("Tomato Soup", "Breadsticks", "Apples"), MealType.LUNCH, "12:00 PM", "3:00 PM", 250, 200),
            FoodDTO("5", "Helping Hands Center", "1212 Aid Ln, Valencia", 39.4715, -0.3735, listOf("Stew", "Rice", "Oranges"), MealType.DINNER, "5:30 PM", "8:30 PM", 150, 120),
            FoodDTO("6", "Sunrise Meals", "1313 Morning Rd, Valencia", 39.4730, -0.3770, listOf("Oatmeal", "Banana", "Juice"), MealType.BREAKFAST, "6:30 AM", "9:30 AM", 120, 100),
            FoodDTO("7", "Harbor Food Point", "1414 Dock Rd, Valencia", 39.4750, -0.3715, listOf("Fish", "Potatoes", "Soup"), MealType.LUNCH, "1:00 PM", "4:00 PM", 180, 150),
            FoodDTO("8", "Valencia Care Meals", "1515 Caring Rd, Valencia", 39.4695, -0.3740, listOf("Rice", "Beans", "Chicken"), MealType.DINNER, "6:00 PM", "8:30 PM", 200, 175),
            FoodDTO("9", "City Hall Free Meals", "1616 Civic Ln, Valencia", 39.4678, -0.3725, listOf("Bread", "Soup", "Salad"), MealType.LUNCH, "12:30 PM", "3:30 PM", 250, 200),
            FoodDTO("10", "Neighborhood Meals", "1717 Community Rd, Valencia", 39.4708, -0.3755, listOf("Vegetables", "Rice", "Fruit"), MealType.DINNER, "5:00 PM", "8:00 PM", 100, 80)
        )
        return dummyList
    }


    suspend fun getMissingList() : List<MissingDTO>{
        val dummyList = listOf(
            MissingDTO(
                uid = "uid1",
                name = "Yassine Sadiqi",
                imageURL = "https://pbs.twimg.com/media/GbuqCh2WwBUjIPZ?format=jpg&name=large",
                date = Date(),
                location = "Alfafar Plaza vieja del parque Alcosa",
                lat = 39.4179,
                lon = -0.3987,
                gender = GenderType.MALE.rawValue,
                character = "67 anos, 1,75, complexion corpulenta, pelo blanco, ojo verdosos, narzi y orejas prominentes, verrugas en pecho, cabeza y oreja derecha"
            ),
            MissingDTO(
                uid = "uid2",
                name = "Rosa Maria Aquilar Hernandez",
                imageURL = "https://pbs.twimg.com/media/Gbub5Q7WgAsWpHj?format=jpg&name=small",
                date = Date(),
                location = "Vera Almeria",
                lat = 37.2527,
                lon = -1.8636,
                gender = GenderType.FEMALE.rawValue,
                character = "15 anos complexion delegada, pelo rubio tenido y ondulado, ojos negros, hoyuelo en menton"
            ),
            MissingDTO(
                uid = "uid3",
                name = "Fernando Duran Nunez",
                imageURL = "https://pbs.twimg.com/media/GbtM0BTXEAURW8g?format=jpg&name=small",
                date = Date(),
                location = "Vera Almeria",
                lat = 37.2527,
                lon = -1.8636,
                gender = GenderType.MALE.rawValue,
                character = "complexion media, estatura media, pelirrojo, ojos azules, calvicie parcial"
            ),
            MissingDTO(
                uid = "uid4",
                name = "Jose C. R",
                imageURL = "https://pbs.twimg.com/media/GbtBQB3XIAMcUew?format=jpg&name=small",
                date = Date(),
                location = "Catarroja Valencia",
                lat = 39.3962,
                lon = -0.4187,
                gender = GenderType.FEMALE.rawValue,
                character = "35 anos, complexio delgada, pelo marron, ojos negros"
            ),
            MissingDTO(
                uid = "uid5",
                name = "Lorenza Marlene Villaverde",
                imageURL = "https://pbs.twimg.com/media/Gbs5tdvXsAkDOMn?format=jpg&name=small",
                date = Date(),
                location = "La Rinconada Sevilla",
                lat = 37.4808,
                lon = -5.9750,
                gender = GenderType.MALE.rawValue,
                character = "66 anos,170 estatura, complexsion gruesa, pelo nego y ondulado, ojos marrones, gafas graduadas"
            ),
            MissingDTO(
                uid = "uid6",
                name = "Javi Sanchez Rocafull",
                imageURL = "https://pbs.twimg.com/media/Gbs2zttWYBEohUC?format=jpg&name=small",
                date = Date(),
                location = "Benetusser Valencia",
                lat = 39.4089,
                lon = -0.3957,
                gender = GenderType.MALE.rawValue,
                character = "54 anos, complexion normal, pelo castano, ojos marrones, gafas graduadas, cadena con una cruz"
            ),
            MissingDTO(
                uid = "uid7",
                name = "Israel Salinas Fernandez",
                imageURL = "https://pbs.twimg.com/media/Gbsn5ZLW8BgjQfa?format=jpg&name=small",
                date = Date(),
                location = "San Cristobal de la Laguna Santa Cruz de Tenerife",
                lat = 28.4874,
                lon = -16.3159,
                gender = GenderType.FEMALE.rawValue,
                character = "55 anos, 155 estatura, complexion gruesa, pelo castano claro, ojos marrones, pequeno corte"
            )
        )

        return dummyList
    }
}