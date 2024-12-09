import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data'; // For handling binary data
import 'package:admin/ui/screen/notification/NotificationModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../ui/screen/missing/model/GenderType.dart';
import '../ui/screen/missing/model/MissingModel.dart';
import '../ui/screen/missing/model/MissingType.dart'; // DateFormat을 사용하여 날짜 형식화

class FirebaseService {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  final String notificationPath = "notification";
  final String missingPath = "missing";

  List<NotificationModel> notificationList = [];
  List<MissingModel> missingList = [];

  FirebaseService() {
  }

  Stream<List<NotificationModel>> observeNotificationList() {
    return db.ref(notificationPath).onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return (data as Map).entries.map((entry) {
          final json = Map<String, dynamic>.from(entry.value);
          return NotificationModel.fromJson(json); // 에러 없이 작동
        }).toList();
      }
      return [];
    });
  }

  // Notification write
  Future<void> createNotificationItem(NotificationModel model,
      Function(NotificationModel) onSuccess, Function(String) onError) async {
    try {
      // 'notify_현재시간' 형식의 UID 생성
      DateTime now = DateTime.now().toUtc().add(Duration(hours: 9));
      String newUid = 'notification_${now.millisecondsSinceEpoch}'; // 리스트의 길이를 기준으로 새로운 UID 생성

      // 새로운 모델 생성
      model = NotificationModel(
        uid: model.uid ?? newUid,
        date: model.date ,
        title: model.title,
        content: model.content,
      );

      // Firebase에 데이터 저장
      DatabaseReference ref = db.ref(notificationPath).child(newUid);
      await ref.set(model.toJson());
      onSuccess(model); // 성공 콜백 실행
    } catch (error) {
      onError('알림 작성 실패: $error'); // 오류 콜백 실행
    }
  }

  // notification delete
  Future<void> deleteNotificationItem(String uid,
      Function(String) onSuccess, Function(String) onError) async {
    try {
      // Firebase 노드 참조
      DatabaseReference ref = db.ref(notificationPath).child(uid);

      // 데이터 삭제
      await ref.remove();
      onSuccess('알림 삭제 성공: $uid'); // 성공 콜백 실행
    } catch (error) {
      onError('알림 삭제 실패: $error'); // 오류 콜백 실행
    }
  }

  Stream<List<MissingModel>> observeMissingList() {
    return db.ref(missingPath).onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        return (data as Map).entries.map((entry) {
          final json = Map<String, dynamic>.from(entry.value);
          return MissingModel.fromJson(json); // 에러 없이 작동
        }).toList();
      }
      return [];
    });
  }


  // Missing read
  Future<void> _readMissingList(Function(List<MissingModel>) onSuccess, Function(String) onError) async {
    try {
      final snapshot = await db.ref(missingPath).get();

      if (snapshot.value != null) {
        // Ensure the value is a Map before proceeding
        if (snapshot.value is Map) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);

          missingList = data.entries.map((entry) {
            final json = Map<String, dynamic>.from(entry.value as Map);
            return MissingModel.fromJson(json);
          }).toList();

          onSuccess(missingList);
        } else {
          onError('Expected data to be a Map, but got a different type.');
        }
      } else {
        missingList = [];
        onSuccess(missingList);
      }
    } catch (error) {
      onError('Failed to load missing data: ${error.toString()}');
    }
  }

  // CREATE: MissingModel 추가
// CREATE: MissingModel 추가
  Future<void> createMissingItem(MissingModel model) async {
    try {

      // 새로운 모델 생성
      model = MissingModel(
        uid: model.uid,
        requestFamilyUID: model.requestFamilyUID,
        missingState: model.missingState,
        name: model.name,
        date: model.date,
        zone: model.zone,
        imageURL: model.imageURL,
        gender: model.gender,
        character: model.character,
        lon: model.lon,
        lat: model.lat,
      );

      // Firebase Realtime Database에 데이터 저장
      DatabaseReference ref = db.ref(missingPath).child(model.uid);
      await ref.set(model.toJson());
    } catch (error) {
      print('Error in createMissingItem: $error'); // 오류 로깅
    }
  }
  // UPDATE: MissingModel 수정
  Future<void> updateMissingItem(
      MissingModel model,
      Function(MissingModel) onSuccess,
      Function(String) onError,
      ) async {
    try {
      DatabaseReference ref = db.ref(missingPath).child(model.uid);

      await ref.update(model.toJson());
      onSuccess(model); // 성공 콜백 실행
    } catch (error) {
      onError(error.toString()); // 실패 콜백 실행
    }
  }

  // DELETE: MissingModel 삭제
  Future<void> deleteMissingItem(String uid, Function(String) onSuccess, Function(String) onError) async {
    try {
      DatabaseReference ref = db.ref(missingPath).child(uid);

      await ref.remove();
      onSuccess('실종자 데이터 삭제 성공: $uid'); // 성공 콜백 실행
    } catch (error) {
      onError('실종자 데이터 삭제 실패: $error'); // 실패 콜백 실행
    }
  }

}


// Future<void> _readNotificationList(
//     Function(List<NotificationModel>) onSuccess, Function(String) onError) async {
//   try {
//     final snapshot = await db.ref(notificationPath).get();
//
//     if (snapshot.value != null) {
//       // snapshot.value가 Map인지 확인
//       if (snapshot.value is Map) {
//         final data = Map<String, dynamic>.from(snapshot.value as Map);
//
//         // 데이터 항목을 NotificationModel로 변환
//         notificationList = data.entries.map((entry) {
//           // Map에서 값을 추출하고 NotificationModel로 변환
//           final json = Map<String, dynamic>.from(entry.value as Map);
//
//           // content 키가 "text"일 수 있기 때문에 "text"와 "content"를 모두 확인
//           if (json['text'] != null) {
//             json['content'] = json['text']; // "text"를 "content"로 변경
//             json.remove('text'); // "text" 키를 제거
//           }
//
//           return NotificationModel.fromJson(json); // 모델 생성
//         }).toList();
//
//         onSuccess(notificationList); // 성공 콜백 호출
//       } else {
//         onError('Expected data to be a Map, but got a different type.');
//       }
//     } else {
//       notificationList = [];
//       onSuccess(notificationList); // 빈 리스트 반환
//     }
//   } catch (e) {
//     onError('Error reading notifications: ${e.toString()}');
//   }
// }
// Future<void> readNotificationList(
//     Function(List<NotificationModel>) onSuccess, Function(String) onError) async {
//   try {
//     final snapshot = await db.ref(notificationPath).get();
//
//     if (snapshot.value != null) {
//       if (snapshot.value is Map) {
//         final data = Map<String, dynamic>.from(snapshot.value as Map);
//         print("notification data : ${data}");
//
//         notificationList = data.entries
//             .where((entry) => entry.key.startsWith('notify_'))
//             .map((entry) {
//           final key = entry.key;
//           final json = Map<String, dynamic>.from(entry.value as Map);
//           return NotificationModel.fromJson(key, json);
//         }).toList();
//
//         onSuccess(notificationList);
//       } else {
//         onError('Expected data to be a Map, but got a different type.');
//       }
//
//       print("notification list : ${notificationList}");
//
//     } else {
//       notificationList = [];
//       onSuccess(notificationList);
//     }
//   } catch (e) {
//     onError('Error reading notifications: ${e.toString()}');
//   }
// }