package com.cavss.porvalencia.ui.screen.volunteer.donation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.cavss.porvalencia.databinding.FragmentVolunteerDonationBinding
import com.cavss.porvalencia.databinding.FragmentVolunteerGroupingBinding

class DonationFragment : Fragment(){
    private var _binding : FragmentVolunteerDonationBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        _binding = FragmentVolunteerDonationBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}