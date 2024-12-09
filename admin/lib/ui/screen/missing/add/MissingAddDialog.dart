import 'dart:html' as html;
import 'package:admin/ui/module/CustomDatePickerView.dart';
import 'package:admin/ui/module/CustomGenderPickerView.dart';
import 'package:flutter/material.dart';
import '../../../custom/imagepicker/ImagePickerWebWidget.dart';
import '../model/GenderType.dart';
import '../model/MissingModel.dart';
import '../model/MissingType.dart';

class MissingAddDialog extends StatefulWidget {
  final Function(MissingModel) onAddedModel;

  const MissingAddDialog({
    Key? key,
    required this.onAddedModel
  }) : super(key: key);

  @override
  State<MissingAddDialog> createState() => _MissingAddDialogState();
}

class _MissingAddDialogState extends State<MissingAddDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _missingLocationController = TextEditingController();
  final TextEditingController _characterController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _requestFamilyUID = TextEditingController();



  void _clearInputs() {
    _nameController.clear();
    _missingLocationController.clear();
    _characterController.clear();
    _latController.clear();
    _lonController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  void _addMissingItem() {
    if (_nameController.text.isEmpty ||
        _selectedDate == null ||
        _missingLocationController.text.isEmpty ||
        _imageURLController.text.isEmpty ||
        _selectedGender == null||
        _characterController.text.isEmpty ||
        _lonController.text.isEmpty ||
        _latController.text.isEmpty
        ) { // 이미지 파일도 체크
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요.')),
      );
      return;
    }

    final missingModel = MissingModel(
      uid: "missing_${_nameController.text}_${DateTime.now().millisecondsSinceEpoch.toString()}",
      requestFamilyUID: _requestFamilyUID.text.isNotEmpty ? _requestFamilyUID.text : "admin",
      missingState: MissingType.MISSING,
      name: _nameController.text,
      date: _selectedDate!,
      zone: _missingLocationController.text,
      imageURL: _imageURLController.text.isNotEmpty ? _imageURLController.text : "", // 선택된 이미지 URL은 추가 로직으로 처리 가능
      gender: _selectedGender ?? GenderType.MALE,
      character: _characterController.text,
      lon: double.tryParse(_lonController.text) ?? 0.0,
      lat: double.tryParse(_latController.text) ?? 0.0,
    );

    widget.onAddedModel(missingModel); // Non-null assertion 사용
    _clearInputs();
    Navigator.of(context).pop();
  }

  Widget customTextField(TextEditingController setController, String labelText, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: setController,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: type,
      ),
    );
  }

  GenderType? _selectedGender = GenderType.MALE;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('실종자 추가'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8, // 최대 높이 제한
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 자식 위젯 높이에 맞춤
            children: [
              customTextField(_nameController, '실종자 이름', TextInputType.text),
              customTextField(_missingLocationController, '실종 위치', TextInputType.text),
              customTextField(_characterController, '외관특징', TextInputType.text),
              customTextField(_imageURLController, '실종자 이미지 url', TextInputType.text),
              customTextField(_requestFamilyUID, '실종 신청자 uid', TextInputType.text),

              Row(
                children: [
                  Expanded(
                    child: CustomGenderPickerView(onGenderChanged: (gender) {
                      setState(() {
                        _selectedGender = gender;
                      });
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDatePickerView(onDatePicked: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: customTextField(_latController, 'Latitude', TextInputType.number),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: customTextField(_lonController, 'Longitude', TextInputType.number),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addMissingItem,
          child: const Text('추가'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
      ],
    );
  }
}

