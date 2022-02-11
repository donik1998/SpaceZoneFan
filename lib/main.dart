import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacefanzone/presentation/screens/earth_photos/earth_photos.dart';
import 'package:spacefanzone/presentation/screens/earth_photos/earth_photos_provider.dart';
import 'package:spacefanzone/presentation/screens/picture_of_day/picture_of_day_provider.dart';
import 'package:spacefanzone/presentation/screens/picture_of_day/picture_of_the_day.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
          unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  List<Widget> _tabs = [
    ChangeNotifierProvider(create: (context) => EarthPhotosProvider(), child: EPIC()),
    ChangeNotifierProvider(create: (context) => PictureOfDayProvider(), child: APOD()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Space Fan Zone'),
        centerTitle: true,
      ),
      body: _tabs.elementAt(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (index) => setState(() => _pageIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Earth daily'),
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Picture of the day'),
        ],
      ),
    );
  }
}
