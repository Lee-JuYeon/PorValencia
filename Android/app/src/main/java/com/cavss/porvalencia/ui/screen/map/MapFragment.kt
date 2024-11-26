package com.cavss.porvalencia.ui.screen.map

import android.Manifest
import android.graphics.Rect
import android.os.Bundle
import android.preference.PreferenceManager
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.content.res.AppCompatResources
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cavss.porvalencia.MainActivity
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.FragmentMapBinding
import com.cavss.porvalencia.model.map.TagDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.tag.TagAdapter
import com.cavss.porvalencia.util.permission.PermissionCallback
import com.cavss.porvalencia.util.permission.PermissionManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.osmdroid.api.IMapController
import org.osmdroid.config.Configuration
import org.osmdroid.events.MapListener
import org.osmdroid.events.ScrollEvent
import org.osmdroid.events.ZoomEvent
import org.osmdroid.tileprovider.tilesource.TileSourceFactory
import org.osmdroid.util.GeoPoint
import org.osmdroid.views.MapView
import org.osmdroid.views.overlay.Marker
import org.osmdroid.views.overlay.mylocation.GpsMyLocationProvider
import org.osmdroid.views.overlay.mylocation.MyLocationNewOverlay

/*
사람을 찾습니다,

대피소(오늘 잘 곳이 필요해요, 성폭력 조심문구),
무료시식소(우리 가족이 먹을 것이 필요해요, 식사알람),
   의약품

  구호단체리스트,

  도와주세요! 마커,
 */
class MapFragment : Fragment(), MapListener {
    private var _binding: FragmentMapBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        _binding = FragmentMapBinding.inflate(inflater, container, false).apply {
            lifecycleOwner = viewLifecycleOwner
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        requestPermission()
        setMap(binding.map)
        setTagRecyclerview(binding.tag)

        val tagList = listOf<TagDTO>(
            TagDTO(uid = "uid1", englishTitle = "hospital", localTitle = R.string.tag_hospital, drawableImage = AppCompatResources.getDrawable(requireContext(), R.drawable.image_hospital)!!),
            TagDTO(uid = "uid2", englishTitle = "bed", localTitle = R.string.tag_bed, drawableImage = requireContext().getDrawable(R.drawable.image_bed)!!),
            TagDTO(uid = "uid3", englishTitle = "food", localTitle = R.string.tag_food, drawableImage = requireContext().getDrawable(R.drawable.image_food)!!),
            TagDTO(uid = "uid4", englishTitle = "helpme", localTitle = R.string.tag_helpme, drawableImage = requireContext().getDrawable(R.drawable.image_emergency)!!)
        )
        tagAdapter.updateList(tagList)
    }

    override fun onScroll(event: ScrollEvent?): Boolean {
        // 스크롤 이벤트 처리 로직 추가
        return true
    }

    override fun onZoom(event: ZoomEvent?): Boolean {
        // 확대/축소 이벤트 처리 로직 추가
        return true
    }

    override fun onResume() {
        super.onResume()
        Configuration.getInstance().load(requireActivity(),
            PreferenceManager.getDefaultSharedPreferences(requireActivity()))
        Configuration.getInstance().cacheMapTileCount = 1024 // 타일 캐시 크기 설정
        binding.map.onResume()
    }

    override fun onPause() {
        super.onPause()
        binding.map.onPause()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun addMarker(latitude: Double, longitude: Double) {
        try {
            val marker = Marker(binding.map).apply {
                position = GeoPoint(latitude, longitude)
                setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM)
                title = "London"
                snippet = "마커 설명"
            }
            binding.map.overlays.add(marker)
        } catch (e: Exception) {
            Log.e("MapFragment", "addMarker error: ${e.localizedMessage}")
        }
    }

    private lateinit var iMapController: IMapController
    private lateinit var mMyLocationOverlay: MyLocationNewOverlay

    private fun setMap(mapView: MapView) {
        try {
            mapView.apply {
                setMultiTouchControls(true)
                setUseDataConnection(true)
                isTilesScaledToDpi = true
                setTileSource(TileSourceFactory.MAPNIK)
            }

            mMyLocationOverlay = MyLocationNewOverlay(GpsMyLocationProvider(requireContext()), mapView).apply {
                enableMyLocation()
//                enableFollowLocation() // 내 현재위치 계속 따라다니기
                isDrawAccuracyEnabled = true
                runOnFirstFix {
                    CoroutineScope(Dispatchers.Main.immediate).launch {
                        // 발렌시아 중심으로 설정
                        iMapController.setCenter(GeoPoint(39.4699, -0.3763))
                        iMapController.animateTo(GeoPoint(39.4699, -0.3763))
                    }
                }
            }

            iMapController = mapView.controller
            iMapController.setZoom(12.0) // 발렌시아에 적합한 줌 레벨 설정

            mapView.apply {
                overlays.add(mMyLocationOverlay)
                addMarker(39.4699, -0.3763) // 발렌시아 중심에 마커 추가
                addMapListener(this@MapFragment)
            }

        } catch (e: Exception) {
            Log.e("MapFragment", "setMap error: ${e.localizedMessage}")
        }
    }


    private fun requestPermission() {
        val permissions = arrayOf(
            Manifest.permission.ACCESS_BACKGROUND_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
        )
        try {
            val permissionManager = PermissionManager(requireActivity() as MainActivity)
            permissionManager.requestPermissions(permissions, object : PermissionCallback {
                override fun onPermissionGranted(grantedPermission: String) {
                    Log.d("MapFragment", "Permission granted: $grantedPermission")
                    setMap(binding.map)
                }

                override fun onPermissionDenied(askPermissionAgain: Boolean, deniedPermission: String) {
                    val message = if (askPermissionAgain) "Permission previously denied: $deniedPermission"
                    else "Permission denied first time: $deniedPermission"
                    Log.e("MapFragment", message)
                }
            })
        } catch (e: Exception) {
            Log.e("mException", "requestPermission error: ${e.localizedMessage}")
        }
    }

    private val tagAdapter by lazy {
        TagAdapter().apply {
            setOnClickListener(object : OnViewHolderClickListener<TagDTO> {
                override fun onClick(item: TagDTO) {
                    Toast.makeText(context, "Clicked: ${item.localTitle}", Toast.LENGTH_SHORT).show()
                }
            })
        }
    }

    private fun setTagRecyclerview(recyclerView: RecyclerView){
        try {
            recyclerView.apply {
                adapter = tagAdapter
                setHasFixedSize(true)
                layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false).apply {
                    initialPrefetchItemCount = 5
                }
                recycledViewPool.setMaxRecycledViews(0, 7)
            }
        } catch (e: Exception) {
            Log.e("mException", "MapFragment, setTagRecyclerview // Error: ${e.localizedMessage}")
        }
    }
}
