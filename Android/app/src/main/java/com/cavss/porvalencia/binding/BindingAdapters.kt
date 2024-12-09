package com.cavss.porvalencia.binding

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import com.cavss.porvalencia.R
import com.cavss.porvalencia.model.map.FoodDTO
import com.cavss.porvalencia.model.map.HospitalDTO
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.model.map.ShelterDTO
import com.cavss.porvalencia.type.GenderType
import com.cavss.porvalencia.type.MealType
import com.cavss.porvalencia.type.MissingType
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object BindingAdapters {

    @JvmStatic
    @BindingAdapter("app:imageURL")
    fun loadImage(imageView: ImageView, url: String?) {
        url?.let {
            Glide.with(imageView.context)
                .load(it)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .thumbnail(0.1f)
                .transition(DrawableTransitionOptions.withCrossFade())
                .into(imageView)
        } ?: imageView.setImageDrawable(null)
    }

    @JvmStatic
    @BindingAdapter("app:missingName")
    fun missingName(textview: TextView, model : MissingDTO) {
        val gender = if (model.gender == GenderType.MALE.rawValue) "🚹" else "🚺"
        textview.text = "${gender} ${model.name}"
    }

    @JvmStatic
    @BindingAdapter("app:missingLocation")
    fun missingLocation(textview: TextView, model : MissingDTO) {
        textview.text = "📍 ${model.location}"
    }

    @JvmStatic
    @BindingAdapter("app:missingDate")
    fun missingDate(textview: TextView, model : MissingDTO) {
        // 핸드폰에 설정된 국가와 언어 기준으로 날짜 포맷
        val dateFormat = SimpleDateFormat("dd-MM-yyyy", Locale.getDefault())
        val formattedDate = dateFormat.format(model.date)
        textview.text = "📆 $formattedDate"
    }

    @JvmStatic
    @BindingAdapter("app:date")
    fun date(textview: TextView, date : Date) {
        // 핸드폰에 설정된 국가와 언어 기준으로 날짜 포맷
        val dateFormat = SimpleDateFormat("dd-MM-yyyy", Locale.getDefault())
        val formattedDate = dateFormat.format(date)
        textview.text = "📆 $formattedDate"
    }

    @JvmStatic
    @BindingAdapter("app:notificationTitle")
    fun notificationTitle(textview: TextView, title : String) {
        textview.text = "📢 $title"
    }

    @JvmStatic
    @BindingAdapter("app:missingState")
    fun missingState(textview: TextView, model : MissingDTO) {
        val stateValue = when(model.state){
            MissingType.MISSING -> textview.context.getString(R.string.missing_state_missing)
            MissingType.DEAD -> textview.context.getString(R.string.missing_state_dead)
            MissingType.ALIVE -> textview.context.getString(R.string.missing_state_alive)
        }
        val missingStateText = "⏰ $stateValue"
        textview.text = missingStateText
    }

    @JvmStatic
    @BindingAdapter("app:call")
    fun call(textview: TextView, digit : String) {
        val REQUEST_CALL_PERMISSION = 100

        textview.text = "📞 ${digit}"

        textview.setOnClickListener {
            val context = textview.context
            val intent = Intent(Intent.ACTION_CALL).apply {
                data = Uri.parse("tel:$digit")
            }

            // 권한 확인
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED) {
                // 권한이 있을 경우 전화 연결
                context.startActivity(intent)
            } else {
                // 권한이 없을 경우 권한 요청
                if (context is Activity) {
                    ActivityCompat.requestPermissions(
                        context,
                        arrayOf(Manifest.permission.CALL_PHONE),
                        REQUEST_CALL_PERMISSION
                    )
                } else {
                    Toast.makeText(context, "전화 권한이 필요합니다.", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    @JvmStatic
    @BindingAdapter("app:location")
    fun location(textview: TextView, location : String) {
        textview.text = "📍 ${location}"
    }

    @JvmStatic
    @BindingAdapter("app:bedState")
    fun bedState(textview: TextView, model:HospitalDTO) {
        if (model.currentBed == null && model.maxBed == null){
            textview.text = ""
        }else if (model.currentBed == null){
            textview.text = "전체 병상수 : ${model.maxBed}"
        }else if (model.maxBed == null){
            textview.text = "현재 병상수 : ${model.currentBed}"
        }else{
            textview.text = "병상수 : ${model.currentBed} / ${model.maxBed}"
        }
    }

    @JvmStatic
    @BindingAdapter("app:peopleState")
    fun peopleState(textview: TextView, model : ShelterDTO) {
        if (model.currentPeople == null && model.maxPeople == null){
            textview.text = ""
        }else if (model.currentPeople == null){
            textview.text = "전체 인원수 : ${model.maxPeople}"
        }else if (model.maxPeople == null){
            textview.text = "현재 수용 인원수 : ${model.currentPeople}"
        }else{
            textview.text = "현재 수용 인원수 : ${model.currentPeople} / ${model.maxPeople}"
        }
    }

    @JvmStatic
    @BindingAdapter("app:isEnterable")
    fun isEnterable(textview: TextView, able : Boolean) {
        val isAble = if (able) "⭕️" else "❌"
        textview.text = "수용가능 : ${isAble}"
    }

    @JvmStatic
    @BindingAdapter("app:mealType")
    fun mealType(textview: TextView, mealType: MealType) {
        when(mealType){
            MealType.BREAKFAST -> {
                textview.text = "🍽️ : 아침 식사"
            }
            MealType.MID_MORNING_SNACK -> {
                textview.text = "🍽️ : 오전 간식"
            }
            MealType.LUNCH -> {
                textview.text = "🍽️ : 점심 식사"
            }
            MealType.AFTERNOON_SNACK -> {
                textview.text = "🍽️ : 오후 간식"
            }
            MealType.DINNER -> {
                textview.text = "🍽️ : 저녁 식사"
            }
        }
    }

    @JvmStatic
    @BindingAdapter("app:workingTime")
    fun workingTime(textview: TextView, model: FoodDTO) {
        textview.text = "⏰ ${model.openTime} - ${model.closeTime}"
    }

    @JvmStatic
    @BindingAdapter("app:portion")
    fun portion(textview: TextView, model : FoodDTO) {
        textview.text = "👥 ${model.currentPortion} / ${model.maxPortion}"
    }
}

