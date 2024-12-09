package com.cavss.porvalencia.ui.screen.map.dialog.notification

import android.opengl.Visibility
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.databinding.HolderMissingBinding
import com.cavss.porvalencia.databinding.HolderNotificationBinding
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class NotificationHolder(
    private val binding: HolderNotificationBinding
) : RecyclerView.ViewHolder(binding.root) {

    init {
        binding.background.setOnClickListener {
            val contentVisibility = binding.contents.visibility
            val newVisibility = if (contentVisibility == View.VISIBLE) View.GONE else View.VISIBLE

            // Toggle visibility
            binding.contents.visibility = newVisibility
        }
    }

    fun bind(model: NotificationModel) {
        binding.apply {
            this.model = model
            executePendingBindings()
        }
    }

    companion object {
        fun create(parent: ViewGroup): NotificationHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val binding = HolderNotificationBinding.inflate(layoutInflater, parent, false)
            return NotificationHolder(binding)
        }
    }
}
