package com.cavss.porvalencia

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.cavss.porvalencia.databinding.ActivityMainBinding
import com.cavss.porvalencia.vm.GroupingVM
import com.cavss.porvalencia.vm.MapVM
import com.cavss.porvalencia.vm.MissingVM

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var navController: NavController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Data Binding을 사용하여 레이아웃 설정
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // NavController 가져오기 (수정된 부분)
        val navHostFragment = supportFragmentManager
            .findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        navController = navHostFragment.navController

        // Bottom Navigation View와 NavController 연결
        binding.bottomNavigation.setupWithNavController(navController)

        setVM()
    }

    private lateinit var groupVM : GroupingVM
    private lateinit var missingVM : MissingVM
    private lateinit var mapVM : MapVM
    private fun setVM(){
        try{
            groupVM = ViewModelProvider(this@MainActivity)[GroupingVM::class.java]
            missingVM = ViewModelProvider(this@MainActivity)[MissingVM::class.java]
            mapVM = ViewModelProvider(this@MainActivity)[MapVM::class.java]
        }catch (e:Exception){
            Log.e("mException", "MainActivity, setVM // Exception : ${e.localizedMessage}")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
    }
}