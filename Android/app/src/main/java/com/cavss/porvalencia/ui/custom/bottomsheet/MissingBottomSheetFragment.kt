package com.cavss.porvalencia.ui.custom.bottomsheet

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.cavss.porvalencia.databinding.SheetMissingBinding
import com.cavss.porvalencia.model.missing.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class MissingBottomSheetFragment(private val missingModel: MissingDTO?) : BottomSheetDialogFragment() {

    private var _binding: SheetMissingBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        _binding = SheetMissingBinding.inflate(inflater, container, false)
        _binding?.run {
            lifecycleOwner = viewLifecycleOwner
            model = missingModel
            listener = object : OnViewHolderClickListener<MissingDTO> {
                override fun onClick(item: MissingDTO) {
                    Log.e("mException", "MissingBottomSheetFragment, onCreateView // Exception: ${item.name}")
                }
            }
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // Additional view setup if needed
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
