package com.cavss.porvalencia.ui.screen.map.dialog.notification

import java.util.Date

data class NotificationModel (
    var uid : String,
    var title : String,
    var contents : String,
    var date : Date
)