// class NotificationModel {
//   final String uid;
//   final DateTime date;
//   final String title;
//   final String content;
//
//   NotificationModel({
//     required this.uid,
//     required this.date,
//     required this.title,
//     required this.content,
//   });
//
//   // fromJson 메서드: JSON 데이터를 NotificationModel 객체로 변환
//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       uid: json['uid'] as String,
//       date: DateTime.parse(json['date'] as String), // ISO 8601 문자열을 DateTime으로 변환
//       title: json['title'] as String,
//       content: json['content'] as String, // "text"에서 "content"로 변경
//     );
//   }
//
//   // toJson 메서드: NotificationModel 객체를 JSON 데이터로 변환
//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'date': date.toIso8601String(), // DateTime을 ISO 8601 문자열로 변환
//       'title': title,
//       'content': content, // "text"에서 "content"로 변경
//     };
//   }
// }

class NotificationModel {
  final String uid;
  final String date;
  final String title;
  final String content;

  NotificationModel({
    required this.uid,
    required this.date,
    required this.title,
    required this.content,
  });

  // factory NotificationModel.fromJson(String key, Map<String, dynamic> json) {
  //   return NotificationModel(
  //     uid: key,
  //     date: json['date'] as String,
  //     title: json['title'] as String,
  //     content: json['content'] as String,
  //   );
  // }
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uid: json['uid'] ?? '', // 기본값 설정
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'content': content,
    };
  }
}