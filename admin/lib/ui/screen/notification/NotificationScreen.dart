import 'dart:js';

import 'package:admin/service/FirebaseService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'NotificationList.dart';
import 'NotificationModel.dart';

class NotificationScreen extends StatelessWidget {

  // Notification 리스트
  List<NotificationModel> notifications = [];

  // 입력 필드 컨트롤러
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // 상단 리스트
          Expanded(
            flex: 2,
            child: StreamBuilder<List<NotificationModel>>(
              stream: _firebaseService.observeNotificationList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No notifications found.'));
                } else {
                  final notifications = snapshot.data!;
                  return NotificationList(notifications: notifications);
                }
              },
            ),
          ),
          Divider(),
          // 하단 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Notification Title'),
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Notification Content'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addNotification,
                  child: Text('Add Notification'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Notification 추가 메서드
  void _addNotification() {
    if (titleController.text.isEmpty || textController.text.isEmpty) {
      print("빈 칸을모두 채워주세요");
      return;
    }

    DateTime now = DateTime.now().toUtc().add(Duration(hours: 9));
    NotificationModel newNotification = NotificationModel(
      uid: 'notification_${now.millisecondsSinceEpoch}',
      date: now.toString(),
      title: titleController.text,
      content: textController.text,
    );

    _firebaseService.createNotificationItem(
      newNotification,
          (createdNotification) {
        titleController.clear();
        textController.clear();
      },
          (error) {
        print("Error adding notification: $error");
      },
    );
  }

}