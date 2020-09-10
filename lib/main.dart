import 'package:flutter/material.dart';
import 'package:spacefanzone/screens/EarthPhotos.dart';
import 'package:spacefanzone/screens/PictureOfTheDay.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Space Fan Zone'),
          centerTitle: true,
          bottom: TabBar(
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorWeight: 2.0,
            labelPadding: EdgeInsets.all(5.0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.blue.shade200,
            tabs: [
              Text('Earth'),
              Text('Pic of the day'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EPIC(),
            APOD(),
          ],
        ),
      ),
    );
  }
}
