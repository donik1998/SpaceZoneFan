import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_fun_zone/presentation/screens/earth_photos/earth_photos.dart';
import 'package:space_fun_zone/presentation/screens/earth_photos/earth_photos_provider.dart';
import 'package:space_fun_zone/presentation/screens/picture_of_day/picture_of_day_provider.dart';
import 'package:space_fun_zone/presentation/screens/picture_of_day/picture_of_the_day.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final List<Widget> tabs = [
    ChangeNotifierProvider(
      create: (context) => EarthPhotosProvider(),
      child: const EPIC(),
    ),
    ChangeNotifierProvider(
      create: (context) => PictureOfDayProvider(),
      child: const APOD(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/space_back.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: tabs.elementAt(_pageIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: _pageIndex,
        onTap: (index) => setState(() => _pageIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Earth daily'),
          BottomNavigationBarItem(icon: Icon(Icons.content_paste), label: 'Picture of the day'),
        ],
      ),
    );
  }
}
