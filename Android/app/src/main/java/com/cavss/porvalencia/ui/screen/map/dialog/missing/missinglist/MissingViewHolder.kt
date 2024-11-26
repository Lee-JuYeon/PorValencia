package com.cavss.porvalencia.ui.screen.map.dialog.missinglist

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.databinding.HolderMissingBinding
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class MissingViewHolder(
    private val binding: HolderMissingBinding
) : RecyclerView.ViewHolder(binding.root) {
    fun bind(model: MissingDTO, clickListener: OnViewHolderClickListener<MissingDTO>) {
        binding.apply {
            this.model = model
            this.listener = clickListener
            executePendingBindings()
        }
    }

    companion object {
        fun create(parent: ViewGroup): MissingViewHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val binding = HolderMissingBinding.inflate(layoutInflater, parent, false)
            return MissingViewHolder(binding)
        }
    }
}