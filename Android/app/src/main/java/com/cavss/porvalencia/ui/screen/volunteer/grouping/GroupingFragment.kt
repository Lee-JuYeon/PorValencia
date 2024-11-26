package com.cavss.porvalencia.ui.screen.volunteer.grouping

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.databinding.FragmentVolunteerGroupingBinding
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.volunteer.grouping.grouplist.GroupingAdapter
import com.cavss.porvalencia.vm.GroupingVM

class GroupingFragment : Fragment(){
    private var _binding : FragmentVolunteerGroupingBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        _binding = FragmentVolunteerGroupingBinding.inflate(inflater, container, false)
        _binding?.run {
            lifecycleOwner = this@GroupingFragment
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setGroupRecyclerview(binding.list)
        updateList()
        super.onViewCreated(view, savedInstanceState)
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private val groupingAdapter by lazy {
        GroupingAdapter().apply {
            setOnClickListener(object : OnViewHolderClickListener<GroupDTO> {
                override fun onClick(item: GroupDTO) {
                    Toast.makeText(context, "Clicked: ${item.title}", Toast.LENGTH_SHORT).show()
                }
            })
        }
    }

    private fun setGroupRecyclerview(recyclerView: RecyclerView){
        try {
            recyclerView.apply {
                adapter = groupingAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false).apply {
                    initialPrefetchItemCount = 5
                }
                recycledViewPool.setMaxRecycledViews(0, 7)
            }
        } catch (e: Exception) {
            Log.e("mException", "GroupingFragment, setTagRecyclerview // Error: ${e.localizedMessage}")
        }
    }


    private val groupVM : GroupingVM by activityViewModels()

    private fun updateList(){
        try {
            groupVM.groupList.observe(viewLifecycleOwner){ list ->
                groupingAdapter.updateList(list)
            }
        } catch (e: Exception) {
            Log.e("mException", "GroupingFragment, updateList // Error: ${e.localizedMessage}")
        }
    }

    private fun addGrouping(){
        try {
            // 그룹 추가 액티비티로 이동.
            groupVM.groupList.observe(viewLifecycleOwner){ list ->
                groupingAdapter.updateList(list)
            }
        } catch (e: Exception) {
            Log.e("mException", "GroupingFragment, updateList // Error: ${e.localizedMessage}")
        }
    }
}

