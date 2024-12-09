import 'package:flutter/material.dart';

class CustomDatePickerView extends StatefulWidget {

  final Function(DateTime?) onDatePicked;

  const CustomDatePickerView({
    Key? key,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  _CustomDatePickerViewState createState() => _CustomDatePickerViewState();
}

class _CustomDatePickerViewState extends State<CustomDatePickerView> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
          widget.onDatePicked(pickedDate); // 선택한 날짜 전달
        }
      },
      child: Text(
        _selectedDate == null
            ? '클릭하여 실종된 날짜 선택'
            : '날짜: ${_selectedDate!.toLocal()}'.split(' ')[0],
      ),
    );
  }
}

/*
CustomDatePickerView(onDatePicked: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  print('선택된 날짜: $date');
                }),
 */