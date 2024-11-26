package com.cavss.porvalencia.ui.screen.map.tag

import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.model.map.TagDTO
import com.cavss.porvalencia.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class TagAdapter() : RecyclerView.Adapter<TagViewHolder>() {

    private val items = ArrayList<TagDTO>()
    fun updateList(newItems : List<TagDTO>?){
        try{
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<TagDTO>(
                    oldList = items,
                    newList = newItems ?: mutableListOf()
                ){},
                false
            )

            diffResult.dispatchUpdatesTo(this)
            items.clear()
            items.addAll(newItems ?: mutableListOf())
        }catch (e:Exception){
            Log.e("mException", "TagAdapter, updateList // Exception : ${e.message}")
        }
    }

    private var clickListener: OnViewHolderClickListener<TagDTO>? = null
    fun setOnClickListener(listener: OnViewHolderClickListener<TagDTO>) {
        this.clickListener = listener
    }

    // ViewHolder 재사용을 위한 풀 사이즈 증가
    init {
        setHasStableIds(true)
    }

    override fun getItemId(position: Int): Long {
        return items[position].uid.hashCode().toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TagViewHolder = TagViewHolder.create(parent)

    override fun onBindViewHolder(holder: TagViewHolder, position: Int) {
        try {
            val item = items.getOrNull(position) ?: return
            val safeClickListener = clickListener ?: object : OnViewHolderClickListener<TagDTO> {
                override fun onClick(item: TagDTO) {
                    // 기본 동작 없음
                }
            }
            holder.bind(item, safeClickListener)
        } catch (e: Exception) {
            Log.e("mException", "TagAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() = items.size

    override fun onViewRecycled(holder: TagViewHolder) {
        try {
            super.onViewRecycled(holder)
        } catch (e: Exception) {
            Log.e("mException", "TagAdapter, onViewRecycled // Exception : ${e.message}")
        }
    }
}
