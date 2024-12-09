import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MissingCell.dart';
import 'model/GenderType.dart';
import 'model/MissingModel.dart';
import 'model/MissingType.dart';

class MissingList extends StatefulWidget {
  final List<MissingModel> missingList;
  final Function(MissingModel) onUpdate;

  const MissingList({
    Key? key,
    required this.missingList,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _MissingListState createState() => _MissingListState();
}

class _MissingListState extends State<MissingList> {
  late TextEditingController _searchController;
  List<MissingModel> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredNotifications = widget.missingList;
  }

  void _searchNotifications() {
    setState(() {
      _filteredNotifications = widget.missingList
          .where((notification) =>
          notification.name.contains(_searchController.text))
          .toList();
    });
  }

  void _addMissingNotification() {
    setState(() {
      widget.missingList.add(MissingModel(
        uid: 'notification_${DateTime.now().millisecondsSinceEpoch}',
        missingState: MissingType.MISSING,
        name: 'Unknown',
        date: DateTime.now(),
        zone: 'Unknown',
        imageURL: '',
        gender: GenderType.MALE,
        character: 'Unknown',
        lon: 0.0,
        lat: 0.0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Notifications',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _searchNotifications,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredNotifications.length,
            itemBuilder: (context, index) {
              final missingModel = _filteredNotifications[index];
              return MissingCell(
                model: missingModel,
                onUpdate: widget.onUpdate,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _addMissingNotification,
            child: Text('Add Missing Notification'),
          ),
        ),
      ],
    );
  }
}