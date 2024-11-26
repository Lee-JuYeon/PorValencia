package com.cavss.porvalencia.ui.screen.map.dialog.missinglist

import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class MissingAdapter() : RecyclerView.Adapter<MissingViewHolder>() {

    private val items = ArrayList<MissingDTO>()
    fun updateList(newItems : List<MissingDTO>?){
        try{
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<MissingDTO>(
                    oldList = items,
                    newList = newItems ?: mutableListOf()
                ){},
                false
            )

            diffResult.dispatchUpdatesTo(this)
            items.clear()
            items.addAll(newItems ?: mutableListOf())
        }catch (e:Exception){
            Log.e("mException", "MissingAdapter, updateList // Exception : ${e.message}")
        }
    }

    private var clickListener: OnViewHolderClickListener<MissingDTO>? = null
    fun setOnClickListener(listener: OnViewHolderClickListener<MissingDTO>) {
        this.clickListener = listener
    }

    // ViewHolder 재사용을 위한 풀 사이즈 증가
    init {
        setHasStableIds(true)
    }

    override fun getItemId(position: Int): Long {
        return items[position].uid.hashCode().toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MissingViewHolder =
        MissingViewHolder.create(parent)

    override fun onBindViewHolder(holder: MissingViewHolder, position: Int) {
        try {
            val item = items.getOrNull(position) ?: return
            val safeClickListener = clickListener ?: object : OnViewHolderClickListener<MissingDTO> {
                override fun onClick(item: MissingDTO) {
                    // 기본 동작 없음
                }
            }
            holder.bind(item, safeClickListener)
        } catch (e: Exception) {
            Log.e("mException", "MissingAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() = items.size

    override fun onViewRecycled(holder: MissingViewHolder) {
        try {
            super.onViewRecycled(holder)
        } catch (e: Exception) {
            Log.e("mException", "MissingAdapter, onViewRecycled // Exception : ${e.message}")
        }
    }
}
