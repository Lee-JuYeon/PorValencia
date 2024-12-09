package com.cavss.porvalencia.util.permission

import android.content.pm.PackageManager
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.cavss.porvalencia.MainActivity



class PermissionManager(
    private val activity: AppCompatActivity,
    private val permissionList : Array<String>
) {

    companion object {
        const val PERMISSION_REQUEST_CODE = 1
    }

    interface PermissionCallback {
        fun onPermissionGranted(grantedPermission : String)
        fun onPermissionDenied(askPermissionAgain: Boolean, deniedPermission : String)
    }


    private fun requestPermissions(callback: PermissionCallback) {
        try {
            permissionList.forEach { permission : String ->
                when (ContextCompat.checkSelfPermission(activity, permission)) {
                    PackageManager.PERMISSION_GRANTED -> {
                        callback.onPermissionGranted(grantedPermission = permission)
                    }
                    PackageManager.PERMISSION_DENIED -> {
                        if (ActivityCompat.shouldShowRequestPermissionRationale(activity, permission)) {
                            // 사용자가 이전에 권한 요청을 거부했고, 권한 요청 이유를 설명할 필요가 있는 경우
                            // 이 부분에서 권한 요청에 대한 설명을 사용자에게 표시할 수 있습니다.
                            ActivityCompat.requestPermissions(activity, permissionList, PERMISSION_REQUEST_CODE)
                            callback.onPermissionDenied(true, permission)
                        } else {
                            //처음 요청하는 경우 그냥 권한 요청
                            ActivityCompat.requestPermissions(activity, permissionList, PERMISSION_REQUEST_CODE)
                            callback.onPermissionDenied(false, permission)
                        }
                    }
                }
            }

        } catch (e: Exception) {
            Log.e("mException", "PermissionManager, requestPermissions // Exception: ${e.localizedMessage}")
        }
    }

    fun checker(onGranted : () -> Unit, onDenied : () -> Unit){
        requestPermissions(object : PermissionCallback {
            override fun onPermissionGranted(grantedPermission: String) {
                Log.d("MapFragment", "Permission granted: $grantedPermission")
                onGranted()
            }

            override fun onPermissionDenied(askPermissionAgain: Boolean, deniedPermission: String) {
                val message = if (askPermissionAgain) "Permission previously denied: $deniedPermission"
                else "Permission denied first time: $deniedPermission"
                onDenied()
                Log.e("MapFragment", message)
            }
        })
    }
}
