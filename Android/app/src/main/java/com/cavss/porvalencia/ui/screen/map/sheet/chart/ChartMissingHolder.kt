package com.cavss.porvalencia.ui.screen.map.sheet.chart

import android.content.Context
import android.graphics.Paint
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.databinding.HolderChartMissingBinding
import com.cavss.porvalencia.databinding.HolderMissingBinding
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener

class ChartMissingHolder(
    private val binding: HolderChartMissingBinding
) : RecyclerView.ViewHolder(binding.root) {
    fun bind(model: ChartModel, clickListener: OnViewHolderClickListener<ChartModel>) {
        binding.apply {
            this.model = model
            this.listener = clickListener
            executePendingBindings()
        }
    }

    companion object {
        fun create(parent: ViewGroup): ChartMissingHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val binding = HolderChartMissingBinding.inflate(layoutInflater, parent, false)
            return ChartMissingHolder(binding)
        }
    }
}