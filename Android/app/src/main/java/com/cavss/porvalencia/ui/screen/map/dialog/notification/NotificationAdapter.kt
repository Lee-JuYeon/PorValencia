package com.cavss.porvalencia.ui.screen.map.dialog.notification

import android.util.Log
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.BaseDiffUtil
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.dialog.missing.missinglist.MissingViewHolder

class NotificationAdapter() : RecyclerView.Adapter<NotificationHolder>() {

    private val items = ArrayList<NotificationModel>()
    fun updateList(newItems : List<NotificationModel>?){
        try{
            val diffResult = DiffUtil.calculateDiff(
                object : BaseDiffUtil<NotificationModel>(
                    oldList = items,
                    newList = newItems ?: mutableListOf()
                ){},
                false
            )

            diffResult.dispatchUpdatesTo(this)
            items.clear()
            items.addAll(newItems ?: mutableListOf())
        }catch (e:Exception){
            Log.e("mException", "NotificationAdapter, updateList // Exception : ${e.message}")
        }
    }


    // ViewHolder 재사용을 위한 풀 사이즈 증가
    init {
        setHasStableIds(true)
    }

    override fun getItemId(position: Int): Long {
        return items[position].uid.hashCode().toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): NotificationHolder =
        NotificationHolder.create(parent)

    override fun onBindViewHolder(holder: NotificationHolder, position: Int) {
        try {
            val item = items.getOrNull(position) ?: return

            holder.bind(item)
        } catch (e: Exception) {
            Log.e("mException", "NotificationAdapter, onBindViewHolder // Exception : ${e.message}")
        }
    }

    override fun getItemCount() = items.size

    override fun onViewRecycled(holder: NotificationHolder) {
        try {
            super.onViewRecycled(holder)
        } catch (e: Exception) {
            Log.e("mException", "NotificationAdapter, onViewRecycled // Exception : ${e.message}")
        }
    }
}