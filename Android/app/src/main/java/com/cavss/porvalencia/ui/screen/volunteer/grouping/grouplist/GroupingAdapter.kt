package com.cavss.porvalencia.ui.screen.volunteer.grouping.grouplist

import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class GroupingAdapter() : RecyclerView.Adapter<GroupingViewHolder>() {

    private val items = ArrayList<GroupDTO>()
    fun updateList(newItems : List<GroupDTO>?){
        try{
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<GroupDTO>(
                    oldList = items,
                    newList = newItems ?: mutableListOf()
                ){},
                false
            )

            diffResult.dispatchUpdatesTo(this)
            items.clear()
            items.addAll(newItems ?: mutableListOf())
        }catch (e:Exception){
            Log.e("mException", "GroupingAdapter, updateList // Exception : ${e.message}")
        }
    }

    private var clickListener: OnViewHolderClickListener<GroupDTO>? = null
    fun setOnClickListener(listener: OnViewHolderClickListener<GroupDTO>) {
        this.clickListener = listener
    }

    // ViewHolder 재사용을 위한 풀 사이즈 증가
    init {
        setHasStableIds(true)
    }

    override fun getItemId(position: Int): Long {
        return items[position].uid.hashCode().toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): GroupingViewHolder =
        GroupingViewHolder.create(parent)

    override fun onBindViewHolder(holder: GroupingViewHolder, position: Int) {
        try {
            val item = items.getOrNull(position) ?: return
            val safeClickListener = clickListener ?: object : OnViewHolderClickListener<GroupDTO> {
                override fun onClick(item: GroupDTO) {
                    // 기본 동작 없음
                }
            }
            holder.bind(item, safeClickListener)
        } catch (e: Exception) {
            Log.e("mException", "GroupingAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() = items.size

    override fun onViewRecycled(holder: GroupingViewHolder) {
        try {
            super.onViewRecycled(holder)
        } catch (e: Exception) {
            Log.e("mException", "GroupingAdapter, onViewRecycled // Exception : ${e.message}")
        }
    }
}
