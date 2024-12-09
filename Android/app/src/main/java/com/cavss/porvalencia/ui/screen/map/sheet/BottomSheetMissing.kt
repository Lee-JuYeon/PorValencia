package com.cavss.porvalencia.ui.screen.map.sheet

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.SheetMapHospitalBinding
import com.cavss.porvalencia.databinding.SheetMapMissingBinding
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.type.MissingType
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.sheet.chart.ChartMissingAdapter
import com.cavss.porvalencia.ui.screen.map.sheet.chart.ChartModel
import com.google.android.material.bottomsheet.BottomSheetDialog
import java.text.SimpleDateFormat
import java.util.Locale

class BottomSheetMissing (
    context: Context,
    private val setModel: MissingDTO
) {

    private val binding: SheetMapMissingBinding = DataBindingUtil.inflate(
        LayoutInflater.from(context),
        R.layout.sheet_map_missing,
        null,
        false
    )

    private val dialog: BottomSheetDialog = BottomSheetDialog(context)

    init {
        setupView()
        setChartView()
    }

    private fun setupView() {
        binding.model = setModel
        binding.listener = null
    }


    fun show() {
        dialog.setContentView(binding.root)
        dialog.show()
    }

    private fun setChartView(){

        val dateFormat = SimpleDateFormat("dd-MM-yyyy", Locale.getDefault())
        val missingDate = dateFormat.format(setModel.date)

        val missingState : String = when(setModel.state){
            MissingType.MISSING -> "수색 중"
            MissingType.DEAD -> "신원 확인 완료"
            MissingType.ALIVE -> "생존 확인 완료"
        }

        val chartList = listOf<ChartModel>(
            ChartModel("uid1", "이름", setModel.name),
            ChartModel("uid2", "성별", setModel.gender),
            ChartModel("uid3", "실종상태", missingState),
            ChartModel("uid4", "실종날짜", missingDate),
            ChartModel("uid5", "실종위치", setModel.location),
            ChartModel("uid6", "외관특징", setModel.character),
        )

        binding.chartView.apply {
            adapter = ChartMissingAdapter().apply {
                setOnClickListener(object: OnViewHolderClickListener<ChartModel>{
                    override fun onClick(item: ChartModel) {
                        Log.d("BottomSheetMissing", "${item.title}이 클릭됨")
                    }
                })
                updateList(chartList)
            }
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false).apply {
                initialPrefetchItemCount = 2
            }
            recycledViewPool.setMaxRecycledViews(0, 2)
        }
    }
}


