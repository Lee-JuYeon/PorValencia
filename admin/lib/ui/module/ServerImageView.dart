import 'package:flutter/material.dart';

class ServerImageView extends StatelessWidget {
  final String imageUrl;

  const ServerImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Center(
          child: Text(
            '에러 : ${error.toString()}',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
