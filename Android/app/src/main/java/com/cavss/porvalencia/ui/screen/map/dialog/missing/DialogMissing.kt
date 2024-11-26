package com.cavss.porvalencia.ui.screen.map.dialog

import android.app.Dialog
import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.widget.EditText
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.DialogMissingBinding
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.bottomsheet.MissingBottomSheetFragment
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.dialog.missinglist.MissingAdapter
import com.cavss.porvalencia.ui.screen.map.sheet.chart.ChartModel
import com.cavss.porvalencia.vm.MissingVM

class DialogMissing(
    context: Context,
    private val missingList: List<MissingDTO>
) {
    private val binding: DialogMissingBinding = DataBindingUtil.inflate(
        LayoutInflater.from(context),
        R.layout.dialog_missing,
        null,
        false
    )

    private val dialog = Dialog(context)
    private var filteredMissingList: List<MissingDTO> = missingList

    private val missingAdapter by lazy {
        MissingAdapter().apply {
            setOnClickListener(object : OnViewHolderClickListener<MissingDTO> {
                override fun onClick(item: MissingDTO) {
                    // 클릭 이벤트 처리
                }
            })

        }
    }

    init {
        setupDialog()
    }

    private fun setupDialog() {
        dialog.setContentView(binding.root)
        setupRecyclerView()
        setupSearchInput()
        missingAdapter.updateList(filteredMissingList)
    }

    fun showDialog() {
        dialog.show()
    }

    private fun setupRecyclerView() {
        binding.missingList.apply {
            adapter = missingAdapter
            setHasFixedSize(true)
            layoutManager = GridLayoutManager(context, 2).apply {
                initialPrefetchItemCount = 5
            }
            recycledViewPool.setMaxRecycledViews(0, 7)
        }
    }

    private fun setupSearchInput() {
        binding.search.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                filterList(s.toString())
            }
            override fun afterTextChanged(s: Editable?) {}
        })
    }

    private fun filterList(query: String) {
        filteredMissingList = if (query.isBlank()) {
            missingList
        } else {
            missingList.filter { it.name.contains(query, ignoreCase = true) }
        }
        missingAdapter.updateList(filteredMissingList)
    }

}
