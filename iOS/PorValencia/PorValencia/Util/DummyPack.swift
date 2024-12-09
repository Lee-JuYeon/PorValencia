//
//  DummyPack.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/10/24.
//

import SwiftUI

final class DummyPack {
    // 싱글톤 인스턴스
    static let shared = DummyPack()
    
    let shelterList = [
        ShelterModel(
            uid: "shelter1",
            title: "Valencia Central Shelter",
            address: "Carrer de Sant Vicent Màrtir, 34, 46002 Valencia",
            lon: -0.376389,
            lat: 39.470239,
            maxBed: 100,
            currentBed: 72,
            isEnterable: true, call: ""
        ),
        ShelterModel(
            uid: "shelter2",
            title: "Valencia North Shelter",
            address: "Avinguda de Guillem de Castro, 73, 46008 Valencia",
            lon: -0.378945,
            lat: 39.475120,
            maxBed: 80,
            currentBed: 55,
            isEnterable: true, call: ""
        ),
        ShelterModel(
            uid: "shelter3",
            title: "Valencia South Shelter",
            address: "Carrer de Xàtiva, 15, 46002 Valencia",
            lon: -0.375328,
            lat: 39.466210,
            maxBed: 50,
            currentBed: 50,
            isEnterable: false, call: ""
        )
    ]

    let foodList = [
        FoodModel(
            uid: "food1",
            title: "Central Food Distribution",
            address: "Plaça de l'Ajuntament, 46002 Valencia",
            lon: -0.377490,
            lat: 39.469750,
            foods: ["Bread", "Water", "Fruit", "Canned Food"],
            mealType: MealType.AFTERNOON_SNACK,
            openTime: "08:00",
            closeTime: "18:00",
            maxPortion: 200,
            currentPortion: 150
        ),
        FoodModel(
            uid: "food2",
            title: "North Valencia Food Station",
            address: "Carrer del Pintor Sorolla, 10, 46002 Valencia",
            lon: -0.372121,
            lat: 39.472539,
            foods: ["Soup", "Sandwiches", "Coffee"],
            mealType: MealType.BREAKFAST,
            openTime: "07:00",
            closeTime: "20:00",
            maxPortion: 100,
            currentPortion: 60
        ),
        FoodModel(
            uid: "food3",
            title: "South Valencia Meal Distribution",
            address: "Carrer de Colón, 3, 46004 Valencia",
            lon: -0.375675,
            lat: 39.463591,
            foods: ["Rice", "Pasta", "Juice", "Salad"],
            mealType: MealType.LUNCH,
            openTime: "09:00",
            closeTime: "21:00",
            maxPortion: 150,
            currentPortion: 120
        )
    ]

    let helpmeList = [
        HelpMeModel(
            uid: "help1",
            address: "Carrer de Quart, 21, 46001 Valencia",
            lon: -0.382418,
            lat: 39.474423,
            userUID: "user1",
            text: "Flooded area. Need immediate assistance to evacuate."
        ),
        HelpMeModel(
            uid: "help2",
            address: "Carrer de la Pau, 12, 46003 Valencia",
            lon: -0.373410,
            lat: 39.473539,
            userUID: "user2",
            text: "Trapped on the second floor. Water levels are rising quickly."
        ),
        HelpMeModel(
            uid: "help3",
            address: "Avinguda de Peris i Valero, 13, 46006 Valencia",
            lon: -0.367888,
            lat: 39.461659,
            userUID: "user3",
            text: "In need of food and water. Supplies are running low."
        )
    ]

    
    let hospitalList: [HospitalModel] = [
        HospitalModel(
            uid: "1",
            hospitalTitle: "Hospital Clínico Universitario de Valencia",
            hospitalAddress: "Av. Blasco Ibáñez, 17, 46010 Valencia, Spain",
            hospitalLon: -0.354568,
            hospitalLat: 39.481061, call: ""
        ),
        HospitalModel(
            uid: "2",
            hospitalTitle: "Hospital Universitario y Politécnico La Fe",
            hospitalAddress: "Av. de Fernando Abril Martorell, 106, 46026 Valencia, Spain",
            hospitalLon: -0.378452,
            hospitalLat: 39.439298, call: ""
        ),
        HospitalModel(
            uid: "3",
            hospitalTitle: "Hospital General Universitario de Valencia",
            hospitalAddress: "Av. de les Tres Creus, s/n, 46014 Valencia, Spain",
            hospitalLon: -0.401420,
            hospitalLat: 39.464283, call: ""
        ),
        HospitalModel(
            uid: "4",
            hospitalTitle: "Casa de Salud",
            hospitalAddress: "C/ del Dr. Manuel Candela, 41, 46021 Valencia, Spain",
            hospitalLon: -0.352322,
            hospitalLat: 39.474824, call: ""
        ),
        HospitalModel(
            uid: "5",
            hospitalTitle: "Hospital IMED Valencia",
            hospitalAddress: "Av. de L'Alcudia, 1, 46960 Valencia, Spain",
            hospitalLon: -0.468890,
            hospitalLat: 39.510235, call: ""
        ),
        HospitalModel(
            uid: "6",
            hospitalTitle: "Hospital Vithas 9 de Octubre",
            hospitalAddress: "C/ de la Vall de la Ballestera, 59, 46015 Valencia, Spain",
            hospitalLon: -0.400165,
            hospitalLat: 39.484875, call: ""
        ),
        HospitalModel(
            uid: "7",
            hospitalTitle: "Centro de Especialidades de Juan Llorens",
            hospitalAddress: "Carrer de Juan Llorens, 60, 46008 Valencia, Spain",
            hospitalLon: -0.392318,
            hospitalLat: 39.469007, call: ""
        ),
        HospitalModel(
            uid: "8",
            hospitalTitle: "Hospital Arnau de Vilanova",
            hospitalAddress: "Carrer de Llano de Zaidía, 4, 46009 Valencia, Spain",
            hospitalLon: -0.376492,
            hospitalLat: 39.489629, call: ""
        )
    ]
    
    
    let missingList: [MissingModel] = [
        MissingModel(uid: "uid1", name: "Yassine Sadiqi", date: Date(), zone: "Alfafar Plaza vieja del parque Alcosa", imageURL: "https://pbs.twimg.com/media/GbuqCh2WwBUjIPZ?format=jpg&name=large", gender: .MALE, character: "67 anos, 1,75, complexion corpulenta, pelo blanco, ojo verdosos, narzi y orejas prominentes, verrugas en pecho, cabeza y oreja derecha", lon: -0.400671, lat: 39.416414),
        
        MissingModel(uid: "uid2", name: "Rosa Maria Aquilar Hernandez", date: Date(), zone: "Vera Almeria", imageURL: "https://pbs.twimg.com/media/Gbub5Q7WgAsWpHj?format=jpg&name=small", gender: .MALE, character: "15 anos complexion delegada, pelo rubio tenido y ondulado, ojos negros, hoyuelo en menton", lon: -1.8635, lat: 37.2569),
        
        MissingModel(uid: "uid3", name: "Fernando Duran Nunez", date: Date(), zone: "Vera Almeria", imageURL: "https://pbs.twimg.com/media/GbtM0BTXEAURW8g?format=jpg&name=small", gender: .MALE, character: "complexion media, estatura media, pelirrojo, ojos azules, calvicie parcial", lon: -1.8635, lat: 37.2569),
        
        MissingModel(uid: "uid4", missingState: MissingType.DEAD, name: "Jose C. R", date: Date(), zone: "Catarroja Valencia", imageURL: "https://pbs.twimg.com/media/GbtBQB3XIAMcUew?format=jpg&name=small", gender: .FEMALE, character: "35 anos, complexio delgada, pelo marron, ojos negros", lon: -0.4018, lat: 39.3942),
        
        MissingModel(uid: "uid5", missingState: MissingType.MISSING, name: "Lorenza Marlene Villaverde", date: Date(), zone: "La Rinconada Sevilla", imageURL: "https://pbs.twimg.com/media/Gbs5tdvXsAkDOMn?format=jpg&name=small", gender: .MALE, character: "66 anos,170 estatura, complexsion gruesa, pelo nego y ondulado, ojos marrones, gafas graduadas", lon: -5.9762, lat: 37.4809),
        
        MissingModel(uid: "uid6", missingState: MissingType.MISSING, name: "Javi Sanchez Rocafull", date: Date(), zone: "Benetusser Valencia", imageURL: "https://pbs.twimg.com/media/Gbs2zttWYBEohUC?format=jpg&name=small", gender: .MALE, character: "54 anos, complexion normal, pelo castano, ojos marrones, gafas graduadas, cadena con una cruz", lon: -0.3998, lat: 39.4163),
        
        MissingModel(uid: "uid7", missingState: MissingType.MISSING, name: "Israel Salinas Fernandez", date: Date(), zone: "San Cristobal de la Laguna Santa Cruz de Tenerife", imageURL: "https://pbs.twimg.com/media/Gbsn5ZLW8BgjQfa?format=jpg&name=small", gender: .FEMALE, character: "55 anos, 155 estatura, complexion gruesa, pelo castano claro, ojos marrones, pequeno corte", lon: -16.3121, lat: 28.4853),
        
        MissingModel(uid: "uid8", missingState: MissingType.DEAD, name: "Carlos Garcia Romero", date: Date(), zone: "Madrid", imageURL: "https://pbs.twimg.com/media/Gbub5Q7WgAsWpHj?format=jpg&name=small", gender: .MALE, character: "40 anos, 1,80m, pelo castaño, ojos azules, complexión atlética", lon: -3.7038, lat: 40.4168),
        
        MissingModel(uid: "uid9", missingState: MissingType.DEAD, name: "Maria Lopez Ruiz", date: Date(), zone: "Barcelona", imageURL: "https://pbs.twimg.com/media/GbtM0BTXEAURW8g?format=jpg&name=small", gender: .FEMALE, character: "28 anos, pelo rubio, ojos verdes, complexión delgada, 1,65m", lon: 2.1734, lat: 41.3851),
        
        MissingModel(uid: "uid10", missingState: MissingType.ALIVE, name: "Luis Antonio Fernandez", date: Date(), zone: "Sevilla", imageURL: "https://pbs.twimg.com/media/GbtBQB3XIAMcUew?format=jpg&name=small", gender: .MALE, character: "50 anos, pelo negro, ojos marrones, 1,70m, delgado", lon: -5.9762, lat: 37.3772),
        
        MissingModel(uid: "uid11", missingState: MissingType.ALIVE, name: "Sofia Martinez Garcia", date: Date(), zone: "Valencia", imageURL: "https://pbs.twimg.com/media/Gbs5tdvXsAkDOMn?format=jpg&name=small", gender: .FEMALE, character: "34 anos, 1,60m, pelo corto castaño claro, ojos marrones, complexión media", lon: -0.3763, lat: 39.4699),
        
        MissingModel(uid: "uid12", missingState: MissingType.ALIVE, name: "Antonio Perez Delgado", date: Date(), zone: "Zaragoza", imageURL: "https://pbs.twimg.com/media/Gbs2zttWYBEohUC?format=jpg&name=small", gender: .MALE, character: "62 anos, 1,85m, pelo canoso, ojos grises, complexión fuerte", lon: -0.8773, lat: 41.6561)
    ]

    
    let volunteerList: [VolunteerModel] = [
        VolunteerModel(uid: "uid1", title: "적십자 구호 청소 모임단체", purpose: "재난민 보호소 봉사 활동", requirement: "", leaderUID: "userUID1", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호", joinedPeoples: ["userUID1", "userUID2", "userUID3"]),
        VolunteerModel(uid: "uid2", title: "환경 정화 봉사단", purpose: "도심 공원 및 거리 청소", requirement: "",leaderUID: "userUID2", maxPeople: 15, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID2", "userUID3", "userUID4"]),
        VolunteerModel(uid: "uid3", title: "어린이 도서 기부팀", purpose: "지역 도서관에 어린이 도서 기증", requirement: "",leaderUID: "userUID3", maxPeople: 20, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID3", "userUID5", "userUID6"]),
        VolunteerModel(uid: "uid4", title: "노숙자 식사 배급팀", purpose: "저소득층 및 노숙자 대상 식사 제공", requirement: "",leaderUID: "userUID4", maxPeople: 12, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID4", "userUID7", "userUID8"]),
        VolunteerModel(uid: "uid5", title: "해변 청소 자원 봉사단", purpose: "해변 및 강가 청소", requirement: "",leaderUID: "userUID5", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID5", "userUID9", "userUID10"]),
        VolunteerModel(uid: "uid6", title: "동물 보호 자원봉사자 모임", purpose: "유기견 보호소 도움 및 후원", requirement: "",leaderUID: "userUID6", maxPeople: 8, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID6", "userUID11"]),
        VolunteerModel(uid: "uid7", title: "청소년 멘토링 프로그램", purpose: "지역 청소년 대상 학습 지원", requirement: "",leaderUID: "userUID7", maxPeople: 25, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID7", "userUID12", "userUID13", "userUID14"]),
        VolunteerModel(uid: "uid8", title: "지역 농업 지원단", purpose: "농촌 봉사 활동 및 농작물 수확 지원", requirement: "",leaderUID: "userUID8", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID8", "userUID15"]),
        VolunteerModel(uid: "uid9", title: "헌혈 캠페인 봉사팀", purpose: "헌혈 장려 및 캠페인 진행", requirement: "",leaderUID: "userUID9", maxPeople: 50, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID9", "userUID16", "userUID17"]),
        VolunteerModel(uid: "uid10", title: "장애인 운동 보조 봉사", purpose: "장애인 운동 보조 및 활동 지원", requirement: "",leaderUID: "userUID10", maxPeople: 5, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID10", "userUID18"]),
        VolunteerModel(uid: "uid11", title: "독거노인 지원 봉사단", purpose: "독거노인 대상 방문 및 지원 활동", requirement: "",leaderUID: "userUID11", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID11", "userUID19", "userUID20"]),
        VolunteerModel(uid: "uid12", title: "재난구호팀", purpose: "재난 발생 시 긴급 구호 활동", requirement: "",leaderUID: "userUID12", maxPeople: 30, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID12", "userUID21"]),
        VolunteerModel(uid: "uid13", title: "지역 병원 봉사팀", purpose: "병원 내 다양한 봉사 활동 지원", requirement: "",leaderUID: "userUID13", maxPeople: 20, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID13", "userUID22", "userUID23"]),
        VolunteerModel(uid: "uid14", title: "학교 안전 도우미", purpose: "학교 주변 안전 확보 및 관리", requirement: "",leaderUID: "userUID14", maxPeople: 15, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID14", "userUID24", "userUID25"]),
        VolunteerModel(uid: "uid15", title: "지역 청소 및 쓰레기 분리수거 팀", purpose: "공공장소 청소 및 분리수거 활동", requirement: "",leaderUID: "userUID15", maxPeople: 12, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID15", "userUID26"]),
        VolunteerModel(uid: "uid16", title: "문화재 보호 봉사단", purpose: "문화재 보존 및 환경 관리", requirement: "",leaderUID: "userUID16", maxPeople: 5, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID16", "userUID27"]),
        VolunteerModel(uid: "uid17", title: "환경 캠페인 기획 봉사팀", purpose: "환경 보호 캠페인 기획 및 진행", requirement: "",leaderUID: "userUID17", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID17", "userUID28", "userUID29"]),
        VolunteerModel(uid: "uid18", title: "아동 보호 기관 지원단", purpose: "아동 보호 기관에서 다양한 지원 활동", requirement: "",leaderUID: "userUID18", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID18", "userUID30"]),
        VolunteerModel(uid: "uid19", title: "재활용품 수집 및 배급 봉사팀", purpose: "재활용품 수거 및 배분 활동", requirement: "",leaderUID: "userUID19", maxPeople: 20, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID19", "userUID31", "userUID32"]),
        VolunteerModel(uid: "uid20", title: "지역 화재 예방 봉사단", purpose: "화재 예방 및 안전 교육", requirement: "",leaderUID: "userUID20", maxPeople: 10, zone: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID20", "userUID33"])
    ]
    
    
    let dummyNotificationList = [
        NotificationMoel(uid: "uid1", title: "title1", text: "내용111", date: Date()),
        NotificationMoel(uid: "uid2", title: "title12", text: "내용2222", date: Date()),
        NotificationMoel(uid: "uid3", title: "title13", text: "내용133333311", date: Date()),
        NotificationMoel(uid: "uid4", title: "title14", text: "내용444444", date: Date()),
        NotificationMoel(uid: "uid5", title: "title15", text: "내용115555551", date: Date()),
        NotificationMoel(uid: "uid6", title: "title16", text: "내용11666666661", date: Date()),
        NotificationMoel(uid: "uid7", title: "title17", text: "내용117777771", date: Date()),
        NotificationMoel(uid: "uid8", title: "title18", text: "내용11888888881", date: Date()),
        NotificationMoel(uid: "uid9", title: "title19", text: "내용119999999991", date: Date()),
        NotificationMoel(uid: "uid10", title: "title20", text: "내용123123123", date: Date()),
        NotificationMoel(uid: "uid11", title: "title21", text: "내용11123123123123131231", date: Date())
    ]
    // private init을 통해 인스턴스화 방지
    private init() {}
}
