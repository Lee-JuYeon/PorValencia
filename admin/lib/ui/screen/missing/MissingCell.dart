import 'dart:io';
import 'package:admin/ui/module/ServerImageView.dart';
import 'package:admin/ui/screen/missing/model/GenderType.dart';
import 'package:flutter/material.dart';
import 'model/MissingModel.dart';
import 'model/MissingType.dart';


class MissingCell extends StatefulWidget {
  final MissingModel model;
  final Function(MissingModel) onUpdate;

  const MissingCell({
    Key? key,
    required this.model,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _MissingCellState createState() => _MissingCellState();
}

class _MissingCellState extends State<MissingCell> {
  late MissingType _currentMissingType;
  late TextEditingController _latController;
  late TextEditingController _lonController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _currentMissingType = widget.model.missingState;
    _latController = TextEditingController(text: widget.model.lat.toString());
    _lonController = TextEditingController(text: widget.model.lon.toString());
  }

  Future<void> _pickImage() async {
    // 간단한 파일 선택 기능 (파일 경로를 입력받는 방식으로 대체 가능)
    // 여기서는 사용자가 파일 경로를 직접 제공한다고 가정합니다.
    // 실제 앱에서는 FilePicker 또는 대체 라이브러리 사용 가능.
    File pickedImage = File('/path/to/your/image.jpg'); // 임의의 경로
    setState(() {
      _imageFile = pickedImage;
    });
  }

  void _updateModel() {
    final updatedModel = MissingModel(
      uid: widget.model.uid,
      requestFamilyUID: widget.model.requestFamilyUID,
      missingState: _currentMissingType,
      name: widget.model.name,
      date: widget.model.date,
      zone: widget.model.zone,
      imageURL: _imageFile?.path ?? widget.model.imageURL,
      gender: widget.model.gender,
      character: widget.model.character,
      lon: double.tryParse(_lonController.text) ?? widget.model.lon,
      lat: double.tryParse(_latController.text) ?? widget.model.lat,
    );
    widget.onUpdate(updatedModel);
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 200;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: ServerImageView(imageUrl: widget.model.imageURL),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름: ${widget.model.name}'),
                  Text('성별: ${widget.model.gender.rawValue}'),
                  Text('실종위치: ${widget.model.zone}'),
                  Text('실종날짜: ${widget.model.date}'),
                  Text('인상착의: ${widget.model.character}'),
                  DropdownButton<MissingType>(
                    value: _currentMissingType,
                    onChanged: (MissingType? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _currentMissingType = newValue;
                        });
                        _updateModel();
                      }
                    },
                    items: MissingType.values.map((MissingType type) {
                      return DropdownMenuItem<MissingType>(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _latController,
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateModel(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _lonController,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateModel(),
                        ),
                      ),
                    ],
                  ),
                  Text('UID: ${widget.model.uid}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
