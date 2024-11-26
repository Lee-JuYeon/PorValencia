package com.cavss.porvalencia.ui.screen.map.sheet.chart

import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.dialog.missinglist.MissingViewHolder

class ChatMissingAdapter() : RecyclerView.Adapter<ChartMissingHolder>() {

    private val items = ArrayList<ChartModel>()
    fun updateList(newItems : List<ChartModel>?){
        try{
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<ChartModel>(
                    oldList = items,
                    newList = newItems ?: mutableListOf()
                ){},
                false
            )

            diffResult.dispatchUpdatesTo(this)
            items.clear()
            items.addAll(newItems ?: mutableListOf())
        }catch (e:Exception){
            Log.e("mException", "ChatMissingAdapter, updateList // Exception : ${e.message}")
        }
    }

    private var clickListener: OnViewHolderClickListener<ChartModel>? = null
    fun setOnClickListener(listener: OnViewHolderClickListener<ChartModel>) {
        this.clickListener = listener
    }

    // ViewHolder 재사용을 위한 풀 사이즈 증가
    init {
        setHasStableIds(true)
    }

    override fun getItemId(position: Int): Long {
        return items[position].uid.hashCode().toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChartMissingHolder =
        ChartMissingHolder.create(parent)

    override fun onBindViewHolder(holder: ChartMissingHolder, position: Int) {
        try {
            val item = items.getOrNull(position) ?: return
            val safeClickListener = clickListener ?: object :
                OnViewHolderClickListener<ChartModel> {
                override fun onClick(item: ChartModel) {
                    // 기본 동작 없음
                }
            }
            holder.bind(item, safeClickListener)
        } catch (e: Exception) {
            Log.e("mException", "ChatMissingAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() = items.size

    override fun onViewRecycled(holder: ChartMissingHolder) {
        try {
            super.onViewRecycled(holder)
        } catch (e: Exception) {
            Log.e("mException", "ChatMissingAdapter, onViewRecycled // Exception : ${e.message}")
        }
    }
}
