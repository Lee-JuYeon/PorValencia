package com.cavss.porvalencia.vm

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.repository.volunteer.GroupRepository

class GroupingVM : ViewModel() {

    private val repository = GroupRepository()

    val groupList: LiveData<List<GroupDTO>> = repository.groupList
}