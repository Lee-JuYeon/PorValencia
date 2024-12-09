enum GenderType {
  MALE,
  FEMALE
}

extension GenderTypeExtension on GenderType {
  String get rawValue {
    switch (this) {
      case GenderType.MALE:
        return "male";
      case GenderType.FEMALE:
        return "female";
    }
  }
}
