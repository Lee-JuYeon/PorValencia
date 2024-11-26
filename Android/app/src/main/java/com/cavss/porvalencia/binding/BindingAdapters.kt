package com.cavss.porvalencia.binding

import android.widget.ImageView
import android.widget.TextView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions
import com.cavss.porvalencia.R
import com.cavss.porvalencia.model.missing.MissingDTO
import com.cavss.porvalencia.type.GenderType
import com.cavss.porvalencia.type.MissingType
import java.text.SimpleDateFormat
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

}

