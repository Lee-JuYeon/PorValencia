package com.cavss.porvalencia.vm

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.cavss.porvalencia.model.map.FoodDTO
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.model.map.ShelterDTO
import com.cavss.porvalencia.repository.map.MapRepository
import com.cavss.porvalencia.repository.missing.MissingRepository
import com.cavss.porvalencia.type.GenderType
import com.cavss.porvalencia.type.MealType
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.Date

class MapVM : ViewModel() {


    /*
    hospital (보건소)
    shelter (쉴곳)
    food (무료배식)
    missing (실종자)

    donation(기부금)
    group(자원봉사)

    vote(설문조사 -> 전염병, 필요한것 조사)
     */

    private val repository = MapRepository()

    // hospital
    private val _hospitalList = MutableLiveData<List<HospitalDTO>>()
    private var _originalHospitalList : List<HospitalDTO> = emptyList()
    val hospitalList: LiveData<List<HospitalDTO>>
        get() = _hospitalList

    private fun loadHospitalList() {
        try {
            viewModelScope.launch(Dispatchers.IO) {
                val mList = repository.getHospitalList()
                _originalHospitalList = mList // 원본 리스트 저장
                _hospitalList.postValue(mList) // UI 업데이트용 리스트
            }
        } catch (e: Exception) {
            Log.e("mException", "MapVM, loadHospitalList // Error : ${e.localizedMessage}")
        }
    }

    // shelter
    private val _shelterList = MutableLiveData<List<ShelterDTO>>()
    private var _originalShelterList: List<ShelterDTO> = emptyList()
    val shelterList: LiveData<List<ShelterDTO>>
        get() = _shelterList

    private fun loadShelterList() {
        try {
            viewModelScope.launch(Dispatchers.IO) {
                val mList = repository.getShelterList()
                _originalShelterList = mList // 원본 리스트 저장
                _shelterList.postValue(mList) // UI 업데이트용 리스트
            }
        } catch (e: Exception) {
            Log.e("mException", "MapVM, loadShelterList // Error : ${e.localizedMessage}")
        }
    }


    // food
    private val _foodList = MutableLiveData<List<FoodDTO>>()
    private var _originalFoodList: List<FoodDTO> = emptyList()
    val foodList: LiveData<List<FoodDTO>>
        get() = _foodList

    private fun loadFoodList() {
        try {
            viewModelScope.launch(Dispatchers.IO) {
                val mList = repository.getFoodList()
                _originalFoodList = mList // 원본 리스트 저장
                _foodList.postValue(mList) // UI 업데이트용 리스트
            }
        } catch (e: Exception) {
            Log.e("mException", "MapVM, loadFoodList // Error : ${e.localizedMessage}")
        }
    }

    // missing
    private val _missingList = MutableLiveData<List<MissingDTO>>()
    private var _originalMissingList: List<MissingDTO> = emptyList()
    val missingList: LiveData<List<MissingDTO>>
        get() = _missingList

    private fun loadMissingList() {
        try {
            viewModelScope.launch(Dispatchers.IO) {
                val mList = repository.getMissingList()
                _originalMissingList = mList // 원본 리스트 저장
                _missingList.postValue(mList) // UI 업데이트용 리스트
            }
        } catch (e: Exception) {
            Log.e("mException", "MapVM, loadMissingList // Error : ${e.localizedMessage}")
        }
    }

    // 이름으로 실종자 검색
    fun searchPeople(name: String) {
        try {
            val filteredList = if (name.isBlank()) {
                _originalMissingList // 검색어가 비어있으면 원본 리스트로 초기화
            } else {
                _originalMissingList.filter { it.name.contains(name, ignoreCase = true) }
            }
            _missingList.value = filteredList // 필터링된 리스트를 _missingList에 반영
        } catch (e: Exception) {
            Log.e("mException", "MapVM, searchPeople // Exception: ${e.localizedMessage}")
        }
    }

    init {
        loadHospitalList()
        loadShelterList()
        loadFoodList()
        loadMissingList()
    }
}
