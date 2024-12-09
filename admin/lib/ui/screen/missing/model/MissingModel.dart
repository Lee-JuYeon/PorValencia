import 'GenderType.dart';
import 'MissingType.dart';

class MissingModel {
  String uid;
  String? requestFamilyUID;
  MissingType missingState;
  String name;
  DateTime date;
  String zone;
  String imageURL;
  GenderType gender;
  String character;
  double lon;
  double lat;

  // 생성자
  MissingModel({
    required this.uid,
    this.requestFamilyUID,
    required this.missingState,
    required this.name,
    required this.date,
    required this.zone,
    required this.imageURL,
    required this.gender,
    required this.character,
    required this.lon,
    required this.lat,
  });

  // hashCode 구현
  @override
  int get hashCode =>
      uid.hashCode ^
      requestFamilyUID.hashCode ^
      missingState.hashCode ^
      name.hashCode ^
      date.hashCode ^
      zone.hashCode ^
      imageURL.hashCode ^
      gender.hashCode ^
      character.hashCode ^
      lon.hashCode ^
      lat.hashCode;

  // equals 구현
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MissingModel &&
        other.uid == uid &&
        other.requestFamilyUID == requestFamilyUID &&
        other.missingState == missingState &&
        other.name == name &&
        other.date == date &&
        other.zone == zone &&
        other.imageURL == imageURL &&
        other.gender == gender &&
        other.character == character &&
        other.lon == lon &&
        other.lat == lat;
  }

  // 객체를 JSON 형식으로 변환
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'requestFamilyUID': requestFamilyUID,
      'missingState': missingState.toString().split('.').last, // Enum 값을 문자열로 변환
      'name': name,
      'date': date.toIso8601String(), // DateTime을 ISO 8601 문자열로 변환
      'zone': zone,
      'imageURL': imageURL,
      'gender': gender.toString().split('.').last, // Enum 값을 문자열로 변환
      'character': character,
      'lon': lon,
      'lat': lat,
    };
  }

  // JSON에서 객체로 변환
  factory MissingModel.fromJson(Map<String, dynamic> json) {
    return MissingModel(
      uid: json['uid'],
      requestFamilyUID: json['requestFamilyUID'],
      missingState: MissingType.values
          .firstWhere((e) => e.toString().split('.').last == json['missingState']),
      name: json['name'],
      date: DateTime.parse(json['date']),
      zone: json['zone'],
      imageURL: json['imageURL'],
      gender: GenderType.values
          .firstWhere((e) => e.toString().split('.').last == json['gender']),
      character: json['character'],
      lon: json['lon'],
      lat: json['lat'],
    );
  }
}