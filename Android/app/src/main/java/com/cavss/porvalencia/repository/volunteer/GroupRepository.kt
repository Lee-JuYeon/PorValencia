package com.cavss.porvalencia.repository.volunteer

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cavss.porvalencia.model.volunteer.group.GroupDTO

class GroupRepository {

    // LiveData 객체로 데이터 관리
    private val _groupData = MutableLiveData<List<GroupDTO>>()
    val groupList: LiveData<List<GroupDTO>> get() = _groupData

    init {
        loadData() // 초기 데이터 로드
    }

    private fun loadData() {
        val groupList = listOf(
            GroupDTO(uid = "uid1", title = "공도청소", limitPeople = 250, currentPeople = 12, purpose = "발렌시아 길거리와 도로 청소", requirement = ""),
            GroupDTO(uid = "uid2", title = "실종자 수색", limitPeople = 200, currentPeople = 45, purpose = "군경부대와 함께 실종자 수색과 구호", requirement = ""),
            GroupDTO(uid = "uid3", title = "구호 물품 분배", limitPeople = 150, currentPeople = 80, purpose = "재해 지역 구호 물품 분배 지원", requirement = ""),
            GroupDTO(uid = "uid4", title = "지역 병원 지원", limitPeople = 300, currentPeople = 150, purpose = "의료진과 함께 병원 지원 활동", requirement = ""),
            GroupDTO(uid = "uid5", title = "교육 캠페인", limitPeople = 100, currentPeople = 40, purpose = "환경 보호 교육 캠페인 진행", requirement = ""),
            GroupDTO(uid = "uid6", title = "동물 구조", limitPeople = 120, currentPeople = 20, purpose = "유기 동물 구조 및 보호소 운영", requirement = ""),
            GroupDTO(uid = "uid7", title = "도서관 건설", limitPeople = 200, currentPeople = 60, purpose = "지역 사회 도서관 건설 및 책 기증", requirement = ""),
            GroupDTO(uid = "uid8", title = "해안가 청소", limitPeople = 180, currentPeople = 90, purpose = "바다와 해안가 쓰레기 수거 활동", requirement = ""),
            GroupDTO(uid = "uid9", title = "환경 보호 세미나", limitPeople = 50, currentPeople = 35, purpose = "환경 보호에 관한 세미나 진행", requirement = ""),
            GroupDTO(uid = "uid10", title = "지역 재난 대응", limitPeople = 500, currentPeople = 250, purpose = "재난 발생 시 지역 주민 구호 활동", requirement = ""),
            GroupDTO(uid = "uid11", title = "강의 자원 봉사", limitPeople = 70, currentPeople = 55, purpose = "학생 대상 무료 강의 제공", requirement = ""),
            GroupDTO(uid = "uid12", title = "공원 개선", limitPeople = 200, currentPeople = 85, purpose = "지역 공원 시설 개선 및 조경 활동", requirement = ""),
            GroupDTO(uid = "uid13", title = "재활용 프로그램", limitPeople = 150, currentPeople = 70, purpose = "재활용 교육 프로그램 운영", requirement = ""),
            GroupDTO(uid = "uid14", title = "해양 생태계 보호", limitPeople = 100, currentPeople = 60, purpose = "해양 생물 보호 캠페인", requirement = ""),
            GroupDTO(uid = "uid15", title = "긴급 구조대", limitPeople = 400, currentPeople = 180, purpose = "재난 구조와 긴급 응급 처치 제공", requirement = "")
        )
        _groupData.value = groupList
    }

    // 데이터 갱신 함수
    fun refreshData(newData: List<GroupDTO>) {
        _groupData.value = newData
    }

}