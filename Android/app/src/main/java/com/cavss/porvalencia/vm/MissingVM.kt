package com.cavss.porvalencia.vm

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.cavss.porvalencia.model.missing.MissingDTO
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.repository.missing.MissingRepository
import com.cavss.porvalencia.repository.volunteer.GroupRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MissingVM : ViewModel() {

    private val repository = MissingRepository()

    // 원본 실종자 리스트
    private val _missingList = MutableLiveData<List<MissingDTO>>()
    val missingList: LiveData<List<MissingDTO>>
        get() = _missingList

    // 검색 초기화를 위한 원본 리스트
    private var _originalList: List<MissingDTO> = emptyList()

    private fun loadMissingList() {
        try {
            viewModelScope.launch(Dispatchers.IO) {
                val mList = repository.getMissingList()
                _originalList = mList // 원본 리스트 저장
                _missingList.postValue(mList) // UI 업데이트용 리스트
            }
        } catch (e: Exception) {
            Log.e("mException", "MissingVM, loadMissingList // Error : ${e.localizedMessage}")
        }
    }

    // 이름으로 실종자 검색
    fun searchPeople(name: String) {
        try {
            val filteredList = if (name.isBlank()) {
                _originalList // 검색어가 비어있으면 원본 리스트로 초기화
            } else {
                _originalList.filter { it.name.contains(name, ignoreCase = true) }
            }
            _missingList.value = filteredList // 필터링된 리스트를 _missingList에 반영
        } catch (e: Exception) {
            Log.e("mException", "MissingVM, searchPeople // Exception: ${e.localizedMessage}")
        }
    }

    init {
        loadMissingList()
    }
}
