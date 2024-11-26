package com.cavss.porvalencia.ui.screen.volunteer.grouping.grouplist

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.databinding.HolderGroupBinding
import com.cavss.porvalencia.model.volunteer.group.GroupDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener


class GroupingViewHolder(
    private val binding: HolderGroupBinding
) : RecyclerView.ViewHolder(binding.root) {
    fun bind(model: GroupDTO, clickListener: OnViewHolderClickListener<GroupDTO>) {
        binding.apply {
            this.model = model
            this.listener = clickListener
            executePendingBindings()
        }
    }

    companion object {
        fun create(parent: ViewGroup): GroupingViewHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val binding = HolderGroupBinding.inflate(layoutInflater, parent, false)
            return GroupingViewHolder(binding)
        }
    }
}
