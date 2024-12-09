import 'package:admin/ui/screen/missing/MissingScreen.dart';
import 'package:admin/ui/screen/notification/NotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스
  final PageController _pageController = PageController(); // PageView 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Center(child: Text('Shelter Screen')),
          Center(child: Text('Food Screen')),
          Center(child: Text('hospital Screen')),
          MissingScreen(),
          NotificationScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue, // 선택된 아이템 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
      type: BottomNavigationBarType.fixed, // 텍스트 항상 표시
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Shelter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital),
          label: 'Hospital',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_search),
          label: 'Missing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
      ],
    );
  }
}
