import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacefanzone/services/EPICapiService.dart';

class EPIC extends StatelessWidget {
  EPICapiQueryBuilder _queryBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          MaterialButton(
            onPressed: () async {
              _queryBuilder = EPICapiQueryBuilder(await _selectDate(context));
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
            child: _queryBuilder == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder(
                    stream: _queryBuilder.getPhotosOnDate().asStream(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.lenght,
                        itemBuilder: (context, index) =>
                            _buildItem(context, snapshot.data.documents[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010, 1),
      lastDate: DateTime(2100),
    );
    print(_pickedDate.toUtc());
    return _pickedDate;
  }

  _buildItem(BuildContext context, document) {}

  // _buildItem(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //   if (snapshot.hasData) {
  //     return Container(
  //       child: Text(
  //         snapshot.data,
  //       ),
  //     );
  //   } else {
  //     return Text('nothing to display');
  //   }
  // }
}
