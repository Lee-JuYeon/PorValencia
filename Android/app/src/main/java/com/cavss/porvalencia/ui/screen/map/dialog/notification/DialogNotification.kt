package com.cavss.porvalencia.ui.screen.map.dialog.notification

import android.app.Dialog
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.cavss.porvalencia.R
import com.cavss.porvalencia.databinding.DialogNotificationBinding
import com.cavss.porvalencia.model.map.MissingDTO
import com.cavss.porvalencia.ui.custom.recyclerview.OnViewHolderClickListener
import com.cavss.porvalencia.ui.screen.map.dialog.missing.missinglist.MissingAdapter
import java.util.Date


class DialogNotification(
    context: Context
) {
    private val binding: DialogNotificationBinding = DataBindingUtil.inflate(
        LayoutInflater.from(context),
        R.layout.dialog_notification,
        null,
        false
    )

    private val dialog = Dialog(context)

    private val notificationAdapter: NotificationAdapter = NotificationAdapter()

    init {
        dialog.setContentView(binding.root)
        setupRecyclerView()
        setContactView()
    }

    fun showDialog() {
        dialog.show()
    }

    private fun setupRecyclerView() {
        Log.d("DialogNotification", "RecyclerView 설정 시작")

        binding.notificationList.apply {
            adapter = notificationAdapter
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false).apply {
                initialPrefetchItemCount = 2
            }
            recycledViewPool.setMaxRecycledViews(0, 7)
        }

        // Dummy data 추가
        val dummyData = listOf(
            NotificationModel("uid1", "title 1", "content 1", Date()),
            NotificationModel("uid2", "title 2", "content 2", Date()),
            NotificationModel("uid3", "title 3", "content 3", Date()),
            NotificationModel("uid4", "title 4", "content 4", Date())
        )

        // 초기화 확인 후 데이터 업데이트
        try {
            notificationAdapter.updateList(dummyData)
            Log.d("DialogNotification", "RecyclerView에 데이터 업데이트 완료")
        } catch (e: Exception) {
            Log.e("DialogNotification", "RecyclerView 데이터 업데이트 실패: ${e.localizedMessage}")
        }
    }

    private fun setContactView() {
        binding.insta.text = "@por_valencia_"
        binding.insta.setOnClickListener {
            try {
                val instagramUrl = "https://www.instagram.com/por_valencia_/"
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(instagramUrl))
                binding.root.context.startActivity(intent)
            } catch (e: Exception) {
                Log.e("DialogNotification", "Instagram 클릭 처리 중 오류: ${e.localizedMessage}")
            }
        }

        binding.x.text = "@por_valencia_"
        binding.x.setOnClickListener {
            try {
                val twitterUrl = "https://x.com/por_valencia_"
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(twitterUrl))
                binding.root.context.startActivity(intent)
            } catch (e: Exception) {
                Log.e("DialogNotification", "Twitter 클릭 처리 중 오류: ${e.localizedMessage}")
            }
        }

        binding.email.setOnClickListener {
            try {
                val emailIntent = Intent(Intent.ACTION_SENDTO).apply {
                    data = Uri.parse("mailto:")
                    putExtra(Intent.EXTRA_EMAIL, arrayOf("redpond2@naver.com"))
                    putExtra(Intent.EXTRA_SUBJECT, "PorValencia 유저의 불편사항입니다.")
                }
                binding.root.context.startActivity(emailIntent)
            } catch (e: Exception) {
                Log.e("DialogNotification", "Email 클릭 처리 중 오류: ${e.localizedMessage}")
            }
        }
    }
}
