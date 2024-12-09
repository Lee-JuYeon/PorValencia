import 'package:admin/ui/screen/missing/MissingList.dart';
import 'package:admin/ui/screen/missing/add/MissingAddButton.dart';
import 'package:admin/ui/screen/missing/add/MissingAddDialog.dart';
import 'package:flutter/material.dart';
import '../../../service/FirebaseService.dart';
import 'model/MissingModel.dart';

class MissingScreen  extends StatelessWidget {

  List<MissingModel> missingList = [];

  final FirebaseService _firebaseService = FirebaseService();

  Widget topWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위젯 간 간격 설정
      children: [
        Expanded(
          child: searchBar(
            onSearch: (value) {
              print("Search Query: $value"); // 검색어 로그 출력
            },
          ),
        ),
        MissingAddButton(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MissingAddDialog(
                    onAddedModel: (missingModel) {
                      // 아이템 추가 동작
                      print("Item added.");

                      _firebaseService.createMissingItem(missingModel);
                    }
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget searchBar({required Function(String) onSearch}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색
        borderRadius: BorderRadius.circular(8), // 모서리 둥글게
        border: Border.all(color: Colors.grey[400]!), // 테두리
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 20),
            child:  Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              onChanged: onSearch, // 텍스트 입력 변화에 따라 콜백 호출
              decoration: const InputDecoration(
                hintText: 'Search...', // 플레이스홀더
                border: InputBorder.none, // 기본 밑줄 제거
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          topWidget(context),
          Expanded(
            flex: 2,
            child: StreamBuilder<List<MissingModel>>(
              stream: _firebaseService.observeMissingList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No missing found.'));
                } else {
                  final missingList = snapshot.data!;
                  return MissingList(
                      missingList: missingList,
                      onUpdate: (missingModel){

                      },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
