import 'package:admin/ui/screen/notification/NotificationCell.dart';
import 'package:flutter/material.dart';

import 'NotificationModel.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationList({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCell(notification: notification);
      },
    );
  }
}

