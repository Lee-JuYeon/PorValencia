package com.cavss.porvalencia.ui.screen.volunteer

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.viewpager2.widget.ViewPager2
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.FragmentVolunteerBinding
import com.cavss.porvalencia.ui.custom.fragment.BaseFragmentAdapter
import com.cavss.porvalencia.ui.screen.volunteer.donation.DonationFragment
import com.cavss.porvalencia.ui.screen.volunteer.grouping.GroupingFragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class VolunteerFragment: Fragment() {
    private var _binding : FragmentVolunteerBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        _binding = FragmentVolunteerBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setTabLayoutWithViewPager2(binding.tabLayout, binding.viewPager)
        super.onViewCreated(view, savedInstanceState)
    }
    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }


    private var donationFragment : DonationFragment? = null
    private var groupingFragment : GroupingFragment? = null
    private fun setTabLayoutWithViewPager2(tabLayout: TabLayout, viewPager2: ViewPager2){
        try{
            donationFragment = DonationFragment()
            groupingFragment = GroupingFragment()
            viewPager2.let {
                var viewpagerAdapter =  object : BaseFragmentAdapter.Adapter(requireActivity()){
                    override fun setFragmentList(): List<Fragment> {
                        return listOf<Fragment>(
                            groupingFragment ?: GroupingFragment(),
                            donationFragment ?: DonationFragment()
                        )
                    }
                }
                it.adapter = viewpagerAdapter
                it.isUserInputEnabled = false // 스크롤로 프래그먼트 이동 억제
            }

            tabLayout.let {
                it.tabMode = TabLayout.MODE_FIXED
                it.tabGravity = TabLayout.GRAVITY_FILL
            }
            TabLayoutMediator(binding.tabLayout, binding.viewPager){ tab, position ->
                val GROUPING = 0
                val DONATION = 1
                when(position){
                    GROUPING -> {
                        tab.text = requireContext().getString(R.string.tab_grouping)
                    }
                    DONATION -> {
                        tab.text = requireContext().getString(R.string.tab_donation)
                    }
                }
            }.attach()
        }catch (e:Exception){
            Log.e("mException", "VolunteerFragment, setTabLayoutWithViewPager2 // Exception : ${e.localizedMessage}")
        }
    }

}