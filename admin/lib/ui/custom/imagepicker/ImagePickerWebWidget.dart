import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class ImagePickerWebWidget extends StatefulWidget {
  final Function(html.File) onImageSelected; // 선택된 이미지를 파일로 전달하는 콜백

  const ImagePickerWebWidget({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _ImagePickerWebWidgetState createState() => _ImagePickerWebWidgetState();
}

class _ImagePickerWebWidgetState extends State<ImagePickerWebWidget> {
  html.File? selectedImage; // 선택된 이미지 파일

  void _pickImage() async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
      ..accept = 'image/*'
      ..click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        setState(() {
          selectedImage = files[0]; // 선택된 파일 저장
        });

        // 선택된 파일을 부모 위젯으로 전달
        widget.onImageSelected(selectedImage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('이미지 선택'),
        ),
        if (selectedImage != null) ...[
          const SizedBox(height: 8),
          FutureBuilder<String>(
            future: _getFilePreview(selectedImage!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Image.network(
                  snapshot.data!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              } else {
                return const Text('이미지를 미리 볼 수 없습니다.');
              }
            },
          ),
        ],
      ],
    );
  }

  /// 선택된 파일의 Data URL을 반환
  Future<String> _getFilePreview(html.File file) async {
    final reader = html.FileReader();
    final completer = Completer<String>();

    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((_) {
      completer.complete(reader.result as String);
    });

    return completer.future;
  }
}

