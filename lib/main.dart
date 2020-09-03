import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text('NASA API features'),
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
        body: Container(
          child: TabBarView(
            children: [
              Center(
                child: Container(
                  color: Colors.red,
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              Center(
                child: Container(
                  color: Colors.red,
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
