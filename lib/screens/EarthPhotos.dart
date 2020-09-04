import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EPIC extends StatelessWidget {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          MaterialButton(
            onPressed: () {
              _selectDate(context);
            },
            height: MediaQuery.of(context).size.height * 0.1,
            minWidth: MediaQuery.of(context).size.width * 0.75,
            splashColor: Colors.white,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.black,
                width: 5.0,
              ),
            ),
            child: Text(
              'Choose date',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: '',
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: StreamBuilder(
              stream: ,
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: ,
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010, 1),
      lastDate: DateTime(2100),
    );
  }
}
