import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [
    BarItemPage(),
    SearchPage(),
    MyPage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: pages[0],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.green.withOpacity(0.5),
          showSelectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(label: "asd", icon: Icon(Icons.apps)),
            BottomNavigationBarItem(label: "asd", icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: "asd", icon: Icon(Icons.person)),
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
    );
  }

  static SearchPage() {}
}

class MyPage {}

BarItemPage() {}
