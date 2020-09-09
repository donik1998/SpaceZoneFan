import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoSuchDateError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 10.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset.zero,
              color: Colors.grey.shade400,
              blurRadius: 5.0,
              spreadRadius: 5.0,
            ),
          ],
          border: Border.all(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.025,
              left: MediaQuery.of(context).size.width * 0.045,
              child: Text(
                'There is no photos on this date\nTry to choose another one',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 18.0,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('DISMISS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
