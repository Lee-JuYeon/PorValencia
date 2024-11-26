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
    
    let volunteerList: [VolunteerModel] = [
        VolunteerModel(uid: "uid1", title: "적십자 구호 청소 모임단체", purpose: "재난민 보호소 봉사 활동", leaderUID: "userUID1", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호", joinedPeoples: ["userUID1", "userUID2", "userUID3"]),
        VolunteerModel(uid: "uid2", title: "환경 정화 봉사단", purpose: "도심 공원 및 거리 청소", leaderUID: "userUID2", maxPeople: 15, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID2", "userUID3", "userUID4"]),
        VolunteerModel(uid: "uid3", title: "어린이 도서 기부팀", purpose: "지역 도서관에 어린이 도서 기증", leaderUID: "userUID3", maxPeople: 20, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID3", "userUID5", "userUID6"]),
        VolunteerModel(uid: "uid4", title: "노숙자 식사 배급팀", purpose: "저소득층 및 노숙자 대상 식사 제공", leaderUID: "userUID4", maxPeople: 12, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID4", "userUID7", "userUID8"]),
        VolunteerModel(uid: "uid5", title: "해변 청소 자원 봉사단", purpose: "해변 및 강가 청소", leaderUID: "userUID5", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID5", "userUID9", "userUID10"]),
        VolunteerModel(uid: "uid6", title: "동물 보호 자원봉사자 모임", purpose: "유기견 보호소 도움 및 후원", leaderUID: "userUID6", maxPeople: 8, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID6", "userUID11"]),
        VolunteerModel(uid: "uid7", title: "청소년 멘토링 프로그램", purpose: "지역 청소년 대상 학습 지원", leaderUID: "userUID7", maxPeople: 25, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID7", "userUID12", "userUID13", "userUID14"]),
        VolunteerModel(uid: "uid8", title: "지역 농업 지원단", purpose: "농촌 봉사 활동 및 농작물 수확 지원", leaderUID: "userUID8", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID8", "userUID15"]),
        VolunteerModel(uid: "uid9", title: "헌혈 캠페인 봉사팀", purpose: "헌혈 장려 및 캠페인 진행", leaderUID: "userUID9", maxPeople: 50, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID9", "userUID16", "userUID17"]),
        VolunteerModel(uid: "uid10", title: "장애인 운동 보조 봉사", purpose: "장애인 운동 보조 및 활동 지원", leaderUID: "userUID10", maxPeople: 5, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID10", "userUID18"]),
        VolunteerModel(uid: "uid11", title: "독거노인 지원 봉사단", purpose: "독거노인 대상 방문 및 지원 활동", leaderUID: "userUID11", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID11", "userUID19", "userUID20"]),
        VolunteerModel(uid: "uid12", title: "재난구호팀", purpose: "재난 발생 시 긴급 구호 활동", leaderUID: "userUID12", maxPeople: 30, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID12", "userUID21"]),
        VolunteerModel(uid: "uid13", title: "지역 병원 봉사팀", purpose: "병원 내 다양한 봉사 활동 지원", leaderUID: "userUID13", maxPeople: 20, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID13", "userUID22", "userUID23"]),
        VolunteerModel(uid: "uid14", title: "학교 안전 도우미", purpose: "학교 주변 안전 확보 및 관리", leaderUID: "userUID14", maxPeople: 15, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID14", "userUID24", "userUID25"]),
        VolunteerModel(uid: "uid15", title: "지역 청소 및 쓰레기 분리수거 팀", purpose: "공공장소 청소 및 분리수거 활동", leaderUID: "userUID15", maxPeople: 12, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID15", "userUID26"]),
        VolunteerModel(uid: "uid16", title: "문화재 보호 봉사단", purpose: "문화재 보존 및 환경 관리", leaderUID: "userUID16", maxPeople: 5, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID16", "userUID27"]),
        VolunteerModel(uid: "uid17", title: "환경 캠페인 기획 봉사팀", purpose: "환경 보호 캠페인 기획 및 진행", leaderUID: "userUID17", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID17", "userUID28", "userUID29"]),
        VolunteerModel(uid: "uid18", title: "아동 보호 기관 지원단", purpose: "아동 보호 기관에서 다양한 지원 활동", leaderUID: "userUID18", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID18", "userUID30"]),
        VolunteerModel(uid: "uid19", title: "재활용품 수집 및 배급 봉사팀", purpose: "재활용품 수거 및 배분 활동", leaderUID: "userUID19", maxPeople: 20, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID19", "userUID31", "userUID32"]),
        VolunteerModel(uid: "uid20", title: "지역 화재 예방 봉사단", purpose: "화재 예방 및 안전 교육", leaderUID: "userUID20", maxPeople: 10, location: "서울시 종로구 창신 1동 42번지 2호",  joinedPeoples: ["userUID20", "userUID33"])
    ]
    
    // private init을 통해 인스턴스화 방지
    private init() {}
}
