import 'package:flutter/material.dart';

import '../screen/missing/model/GenderType.dart';

// 성별 타입 정의 (사용자가 제공한 GenderType 열거형)

class CustomGenderPickerView extends StatefulWidget {
  final Function(GenderType) onGenderChanged;

  const CustomGenderPickerView({
    Key? key,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  _CustomGenderPickerViewState createState() => _CustomGenderPickerViewState();
}

class _CustomGenderPickerViewState extends State<CustomGenderPickerView> {
  late GenderType _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = GenderType.MALE;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GenderType>(
      value: _selectedGender,
      onChanged: (GenderType? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedGender = newValue;
          });
          widget.onGenderChanged(newValue); // 선택한 성별 전달
        }
      },
      items: GenderType.values.map((GenderType type) {
        return DropdownMenuItem(
          value: type,
          child: Text(_formatGenderType(type)), // 성별 텍스트 포맷
        );
      }).toList(),
    );
  }

  String _formatGenderType(GenderType gender) {
    switch (gender) {
      case GenderType.MALE:
        return "남성";
      case GenderType.FEMALE:
        return "여성";
    }
  }
}

/*
GenderView(
        initialGender: GenderType.MALE,
        onGenderChanged: (gender) {
          setState(() {
            selectedGender = gender;
          });
          print('선택된 성별: $gender');
        },
      ),
 */