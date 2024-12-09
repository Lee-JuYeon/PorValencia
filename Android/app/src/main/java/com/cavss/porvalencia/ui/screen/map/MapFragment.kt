package com.cavss.porvalencia.ui.screen.map

import android.Manifest
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.preference.PreferenceManager
import android.util.Log
import android.util.TypedValue
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.content.res.AppCompatResources
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.request.RequestListener
import com.cavss.porvalencia.MainActivity
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.FragmentMapBinding
import com.cavss.porvalencia.model.map.FoodDTO
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.model.map.ShelterDTO
import com.cavss.porvalencia.model.map.TagDTO
import com.cavss.porvalencia.type.MissingType
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.dialog.notification.DialogNotification
import com.cavss.porvalencia.ui.screen.map.sheet.BottomSheetFood
import com.cavss.porvalencia.ui.screen.map.sheet.BottomSheetHospital
import com.cavss.porvalencia.ui.screen.map.sheet.BottomSheetMissing
import com.cavss.porvalencia.ui.screen.map.sheet.BottomSheetShelter
import com.cavss.porvalencia.ui.screen.map.tag.TagAdapter
import com.cavss.porvalencia.util.permission.PermissionManager
import com.cavss.porvalencia.vm.MapVM
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
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
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

/*
사람을 찾습니다,

대피소(오늘 잘 곳이 필요해요, 성폭력 조심문구),
무료시식소(우리 가족이 먹을 것이 필요해요, 식사알람),
   의약품

  구호단체리스트,

  도와주세요! 마커,
 */

class MapFragment : Fragment(), MapListener {


    private val mapVM : MapVM by activityViewModels()
    private var _binding: FragmentMapBinding? = null
    private val binding get() = _binding!!

    private var hospitalList : List<HospitalDTO> = listOf()
    private var shelterList : List<ShelterDTO> = listOf()
    private var foodList : List<FoodDTO> = listOf()
    private var missingList : List<MissingDTO> = listOf()
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        _binding = FragmentMapBinding.inflate(inflater, container, false).apply {
            lifecycleOwner = viewLifecycleOwner
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        mapVM.hospitalList.observe(viewLifecycleOwner) { hospitalList ->
            this.hospitalList = hospitalList
        }
        mapVM.shelterList.observe(viewLifecycleOwner) { shelterList ->
            this.shelterList = shelterList
        }
        mapVM.foodList.observe(viewLifecycleOwner) { foodList ->
            this.foodList = foodList
        }
        mapVM.missingList.observe(viewLifecycleOwner) { missingList ->
            this.missingList = missingList
        }

        PermissionManager(requireActivity() as MainActivity, arrayOf(
            Manifest.permission.ACCESS_BACKGROUND_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
        )).checker(
            onGranted = {
                setMap(binding.map)
                setTagRecyclerview(binding.tag)
                setNotification()
            },
            onDenied = {

            }
        )
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
                addMapListener(this@MapFragment)
            }

        } catch (e: Exception) {
            Log.e("MapFragment", "setMap error: ${e.localizedMessage}")
        }
    }

    private suspend fun createCustomMarkerView(
        serverImage: String?,
        placeholderImage: Int?
    ): Drawable = withContext(Dispatchers.Main) {
        suspendCoroutine { continuation ->
            val view = LayoutInflater.from(requireContext()).inflate(R.layout.custom_marker, null)
            val imageView = view.findViewById<ImageView>(R.id.markerImage)

            if (!serverImage.isNullOrEmpty()) {
                Glide.with(requireContext())
                    .load(serverImage)
                    .circleCrop()
                    .placeholder(placeholderImage ?: R.drawable.image_missing)
                    .listener(object : RequestListener<Drawable> {
                        override fun onLoadFailed(
                            e: GlideException?,
                            model: Any?,
                            target: com.bumptech.glide.request.target.Target<Drawable>?,
                            isFirstResource: Boolean
                        ): Boolean {
                            imageView.setImageResource(placeholderImage ?: R.drawable.image_missing)
                            val bitmap = createBitmapFromView(view)
                            continuation.resume(BitmapDrawable(requireContext().resources, bitmap))
                            return false
                        }

                        override fun onResourceReady(
                            resource: Drawable,
                            model: Any?,
                            target: com.bumptech.glide.request.target.Target<Drawable>?,
                            dataSource: DataSource?,
                            isFirstResource: Boolean
                        ): Boolean {
                            imageView.setImageDrawable(resource)
                            val bitmap = createBitmapFromView(view)
                            continuation.resume(BitmapDrawable(requireContext().resources, bitmap))
                            return false
                        }
                    })
                    .submit()
            } else {
                imageView.setImageResource(placeholderImage ?: R.drawable.image_missing)
                val bitmap = createBitmapFromView(view)
                continuation.resume(BitmapDrawable(requireContext().resources, bitmap))
            }
        }
    }

    private fun createBitmapFromView(view: View): Bitmap {
        // Convert 20dp to pixels
        val widthInPx = TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP, 30f, view.context.resources.displayMetrics
        ).toInt()

        val heightInPx = TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP, 30f, view.context.resources.displayMetrics
        ).toInt()

        // Measure and layout the view with the specified size
        view.measure(
            View.MeasureSpec.makeMeasureSpec(widthInPx, View.MeasureSpec.EXACTLY),
            View.MeasureSpec.makeMeasureSpec(heightInPx, View.MeasureSpec.EXACTLY)
        )
        view.layout(0, 0, widthInPx, heightInPx)

        // Create the bitmap
        val bitmap = Bitmap.createBitmap(
            widthInPx,
            heightInPx,
            Bitmap.Config.ARGB_8888
        )
        val canvas = Canvas(bitmap)
        view.draw(canvas)

        return bitmap
    }
    private suspend fun addMarker(
        lat: Double,
        lon: Double,
        serverImage: String? = null,
        placeholderImage: Int? = null,
        onClick: () -> Unit
    ) = withContext(Dispatchers.Main) {
        try {
            val icon = createCustomMarkerView(serverImage, placeholderImage)
            val customMarker = Marker(binding.map).apply {
                position = GeoPoint(lat, lon)
                setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM)
                this.icon = icon
                setOnMarkerClickListener { _, _ ->
                    onClick()
                    true
                }
            }
            binding.map.overlays.add(customMarker)
        } catch (e: Exception) {
            Log.e("MapFragment", "addMarker error: ${e.localizedMessage}")
        }
    }
    private fun setTagRecyclerview(recyclerView: RecyclerView){
        try {
            recyclerView.apply {
                adapter = TagAdapter().apply {
                    setOnClickListener(object : OnViewHolderClickListener<TagDTO> {
                        override fun onClick(item: TagDTO) {
                            when(item.englishTitle){
                                "hospital" -> {
                                    binding.map.apply {
                                        overlays.clear()
                                        hospitalList.forEach {model : HospitalDTO ->
                                            viewLifecycleOwner.lifecycleScope.launch {
                                                addMarker(
                                                    lat = model.latitude,
                                                    lon = model.longitude,
                                                    placeholderImage = R.drawable.image_hospital,
                                                    onClick = {
                                                        val sheet = BottomSheetHospital(requireContext(), model)
                                                        sheet.show()
                                                    }
                                                )
                                            }
                                        }
                                        invalidate()
                                    }
                                }
                                "shelter" -> {
                                    binding.map.apply {
                                        overlays.clear()
                                        shelterList.forEach { model : ShelterDTO ->
                                            viewLifecycleOwner.lifecycleScope.launch {
                                                addMarker(
                                                    lat = model.lat,
                                                    lon = model.lon,
                                                    placeholderImage = R.drawable.image_bed,
                                                    onClick = {
                                                        val sheet = BottomSheetShelter(requireContext(), model)
                                                        sheet.show()
                                                    }
                                                )
                                            }
                                        }
                                        invalidate()
                                    }
                                }
                                "food" -> {
                                    binding.map.apply {
                                        overlays.clear()
                                        foodList.forEach { model : FoodDTO ->
                                            viewLifecycleOwner.lifecycleScope.launch {
                                                addMarker(
                                                    lat = model.latitude,
                                                    lon = model.longitude,
                                                    placeholderImage = R.drawable.image_food,
                                                    onClick = {
                                                        val sheet = BottomSheetFood(requireContext(), model)
                                                        sheet.show()
                                                    }
                                                )
                                            }
                                        }
                                        invalidate()
                                    }
                                }
                                "missing" -> {
//                                    val missingDialog = DialogMissing(requireContext(), missingList)
//                                    missingDialog.showDialog()
                                    binding.map.apply {
                                        overlays.clear()
                                        missingList.forEach { model : MissingDTO ->
                                            if (model.state == MissingType.MISSING){
                                                model.lat?.let { lat ->
                                                    model.lon?.let { lon ->
                                                        viewLifecycleOwner.lifecycleScope.launch {
                                                            addMarker(
                                                                lat = lat,
                                                                lon = lon,
                                                                serverImage = model.imageURL,
                                                                onClick = {
                                                                    val sheet = BottomSheetMissing(requireContext(), model)
                                                                    sheet.show()
                                                                }
                                                            )
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        invalidate()
                                    }
                                }
                            }
                            Toast.makeText(context, "Clicked: ${item.localTitle}", Toast.LENGTH_SHORT).show()
                        }
                    })
                    updateList(
                        listOf<TagDTO>(
                            TagDTO(uid = "uid1", englishTitle = "hospital", localTitle = R.string.tag_hospital, drawableImage = AppCompatResources.getDrawable(requireContext(), R.drawable.image_hospital)!!),
                            TagDTO(uid = "uid2", englishTitle = "shelter", localTitle = R.string.tag_bed, drawableImage = AppCompatResources.getDrawable(requireContext(), R.drawable.image_bed)!!),
                            TagDTO(uid = "uid3", englishTitle = "food", localTitle = R.string.tag_food, drawableImage = AppCompatResources.getDrawable(requireContext(), R.drawable.image_food)!!),
                            TagDTO(uid = "uid4", englishTitle = "missing", localTitle = R.string.tag_missing, drawableImage = AppCompatResources.getDrawable(requireContext(), R.drawable.image_missing)!!)
                        )
                    )
                }
                setHasFixedSize(true)
                layoutManager = GridLayoutManager(context, 3) // 가로 3개로 설정
                recycledViewPool.setMaxRecycledViews(0, 7)
            }
        } catch (e: Exception) {
            Log.e("mException", "MapFragment, setTagRecyclerview // Error: ${e.localizedMessage}")
        }
    }

    private fun setNotification(){
        binding.notification.setOnClickListener {
            val sheet = DialogNotification(requireContext())
            sheet.showDialog()
        }
    }
}