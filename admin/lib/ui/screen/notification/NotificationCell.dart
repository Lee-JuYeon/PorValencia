import 'package:admin/ui/screen/notification/NotificationModel.dart';
import 'package:flutter/material.dart';

class NotificationCell extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCell({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(notification.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   '📅: ${notification.date.year}-${notification.date.month.toString().padLeft(2, '0')}-${notification.date.day.toString().padLeft(2, '0')}',
                // ),
                Text(
                  '📅: ${notification.date}',
                ),
                Text('🆔: ${notification.uid}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
