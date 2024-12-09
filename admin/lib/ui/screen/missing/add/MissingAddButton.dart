import 'package:flutter/material.dart';

class MissingAddButton extends StatelessWidget {

  final VoidCallback onTap;

  const MissingAddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), // 좌우 마진
        child: Icon(
          Icons.add_circle,
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }
}
