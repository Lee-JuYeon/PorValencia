package com.cavss.porvalencia.dummy

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.ActivityMainBinding
import com.cavss.porvalencia.databinding.ActivityMissingAddBinding
import com.cavss.porvalencia.vm.GroupingVM
import com.cavss.porvalencia.vm.MissingVM

class MissingAddActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMissingAddBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Data Binding을 사용하여 레이아웃 설정
        binding = ActivityMissingAddBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }


    override fun onDestroy() {
        super.onDestroy()
    }
}