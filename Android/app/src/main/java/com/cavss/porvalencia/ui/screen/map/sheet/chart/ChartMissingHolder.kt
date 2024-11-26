package com.cavss.porvalencia.ui.screen.map.sheet.chart

import android.content.Context
import android.graphics.Paint
import android.util.AttributeSet
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView

class ChartView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {

    private val recyclerView: RecyclerView
    private val chatAdapter: ChatAdapter


    init {
        orientation = VERTICAL
        layoutParams = LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )

        recyclerView = RecyclerView(context).apply {
            layoutParams = LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
            layoutManager = GridLayoutManager(context, 1)
        }
        addView(recyclerView)

        chatAdapter = ChatAdapter()
        recyclerView.adapter = chatAdapter
    }

    // Set Data
    fun setData(data: List<ChartModel>) {
        val maxTitleWidth = calculateMaxTitleWidth(data)
        chatAdapter.setData(data, maxTitleWidth)
    }

    // Calculate max title width
    private fun calculateMaxTitleWidth(data: List<ChartModel>): Int {
        val paint = Paint().apply {
            textSize = 48f // Adjust text size if needed
        }
        return data.maxOfOrNull { paint.measureText(it.title).toInt() } ?: 0
    }

    // Adapter class inside ChatView
    inner class ChatAdapter : RecyclerView.Adapter<ChatAdapter.ChatViewHolder>() {

        private var data: List<ChartModel> = emptyList()
        private var maxTitleWidth: Int = 0

        inner class ChatViewHolder(val container: LinearLayout) : RecyclerView.ViewHolder(container) {
            val titleTextView: TextView
            val contentTextView: TextView

            init {
                container.orientation = HORIZONTAL
                container.layoutParams = RecyclerView.LayoutParams(
                    RecyclerView.LayoutParams.MATCH_PARENT,
                    RecyclerView.LayoutParams.WRAP_CONTENT
                )

                titleTextView = TextView(context).apply {
                    layoutParams = LayoutParams(
                        LayoutParams.WRAP_CONTENT,
                        LayoutParams.WRAP_CONTENT
                    )
                    textSize = 16f
                }

                contentTextView = TextView(context).apply {
                    layoutParams = LayoutParams(
                        0,
                        LayoutParams.WRAP_CONTENT,
                        1f
                    )
                    textSize = 16f
                }

                container.addView(titleTextView)
                container.addView(contentTextView)
            }
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChatViewHolder {
            val container = LinearLayout(context)
            return ChatViewHolder(container)
        }

        override fun onBindViewHolder(holder: ChatViewHolder, position: Int) {
            val item = data[position]
            holder.titleTextView.text = item.title
            holder.contentTextView.text = item.text

            // Adjust the title width to the max calculated width
            holder.titleTextView.layoutParams.width = maxTitleWidth
        }

        override fun getItemCount(): Int = data.size

        fun setData(newData: List<ChartModel>, maxWidth: Int) {
            this.data = newData
            this.maxTitleWidth = maxWidth
            notifyDataSetChanged()
        }
    }

}