package com.cavss.porvalencia.ui.screen.map.sheet

import android.content.Context
import android.view.LayoutInflater
import androidx.databinding.DataBindingUtil
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.SheetMapHospitalBinding
import com.cavss.porvalencia.databinding.SheetMapShelterBinding
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.ShelterDTO
import com.google.android.material.bottomsheet.BottomSheetDialog

class BottomSheetShelter(
    context: Context,
    private val setModel: ShelterDTO
) {

    private val binding: SheetMapShelterBinding = DataBindingUtil.inflate(
        LayoutInflater.from(context),
        R.layout.sheet_map_shelter,
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
