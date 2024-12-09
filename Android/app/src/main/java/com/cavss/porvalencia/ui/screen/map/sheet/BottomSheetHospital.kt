package com.cavss.porvalencia.ui.screen.map.sheet

import android.content.Context
import android.view.LayoutInflater
import androidx.databinding.DataBindingUtil
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.SheetMapHospitalBinding
import com.cavss.porvalencia.model.map.FoodDTO
import com.cavss.porvalencia.model.map.HospitalDTO
import com.google.android.material.bottomsheet.BottomSheetDialog


class BottomSheetHospital(
    context: Context,
    private val setModel: HospitalDTO
) {

    private val binding: SheetMapHospitalBinding = DataBindingUtil.inflate(
        LayoutInflater.from(context),
        R.layout.sheet_map_hospital,
        null,
        false
    )

    private val dialog: BottomSheetDialog = BottomSheetDialog(context)

    init {
        setupView()
    }

    private fun setupView() {
        binding.model = setModel
        binding.listener
    }

    private fun handleActionClick() {
        // 필요한 로직 처리 후 다이얼로그 닫기
        dialog.dismiss()
    }

    fun show() {
        dialog.setContentView(binding.root)
        dialog.show()
    }
}
