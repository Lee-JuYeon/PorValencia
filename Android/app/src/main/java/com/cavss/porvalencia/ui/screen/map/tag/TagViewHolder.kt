package com.cavss.porvalencia.ui.screen.map.tag

import android.content.res.ColorStateList
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.content.res.AppCompatResources
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.HolderTagBinding
import com.cavss.porvalencia.model.map.TagDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class TagViewHolder(
    private val binding: HolderTagBinding
) : RecyclerView.ViewHolder(binding.root) {

    private var isBorderActive = false

    fun bind(model: TagDTO, clickListener: OnViewHolderClickListener<TagDTO>) {
        binding.apply {
            this.model = model
            this.listener = clickListener
            executePendingBindings()
        }

        // Toggle border effect on click
        binding.backgroundBorder.setOnClickListener {
            isBorderActive = !isBorderActive
            updateBorderEffect()
            clickListener.onClick(model)
        }
    }

    private fun updateBorderEffect() {
        if (isBorderActive) {
            // Set Instagram gradient border effect
            binding.backgroundBorder.backgroundTintList = ColorStateList.valueOf(Color.BLUE)
        } else {
            binding.backgroundBorder.backgroundTintList = null
        }
    }

    companion object {
        fun create(parent: ViewGroup): TagViewHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val binding = HolderTagBinding.inflate(layoutInflater, parent, false)
            return TagViewHolder(binding)
        }
    }
}
