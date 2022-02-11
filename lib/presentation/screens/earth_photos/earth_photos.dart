import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacefanzone/data/models/epic_image_model.dart';
import 'package:spacefanzone/data/services/epic_service.dart';

class EPIC extends StatefulWidget {
  @override
  _EPICState createState() => _EPICState();
}

class _EPICState extends State<EPIC> {
  List<EpicImageModel> _images = List<EpicImageModel>.empty();
  late DateTime _currentDateTime;
  late List<String> _months;
  String? _dayEnding;

  @override
  void initState() {
    super.initState();
    EPICAPIService.getImages()
      ..then((images) => {
            setState(() {
              _images = images;
            })
          });
    _currentDateTime = DateTime.now();
    _months = List<String>.empty();
    _months.add('offsetItem');
    _months.add('January');
    _months.add('February');
    _months.add('March');
    _months.add('April');
    _months.add('May');
    _months.add('June');
    _months.add('July');
    _months.add('August');
    _months.add('September');
    _months.add('October');
    _months.add('November');
    _months.add('December');
    if (_currentDateTime.day == 1) {
      _dayEnding = 'st';
    } else if (_currentDateTime.day == 2) {
      _dayEnding = 'nd';
    } else if (_currentDateTime.day == 3) {
      _dayEnding = 'rd';
    } else {
      _dayEnding = 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0125,
          ),
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
                color: Colors.white,
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
                fontFamily: 'Overpass-Regular',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 10.0,
            ),
            child: Text(
              'Most recent photos of Earth to ${_currentDateTime.day}$_dayEnding of ${_months[_currentDateTime.month]}, ${_currentDateTime.year}',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: _images.isEmpty
                ? Center(
                    child: FlareActor(
                      'assets/images/LiquidLoad.flr',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      animation: 'Loading',
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            child: _buildItem(_images[index]),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              'Taken on ' +
                                  '${_images[index].date!.day}$_dayEnding of ${_months[_images[index].date!.month]}, ${_images[index].date!.year}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
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
    if (_pickedDate is DateTime)
      EPICAPIService.getImagesToDate(_pickedDate, context).then(
        (images) => {
          setState(
            () {
              _images = images;
              _currentDateTime = _pickedDate;
            },
          ),
        },
      );
  }

  Widget _buildItem(EpicImageModel currentImage) {
    String convertedDateTime =
        '${currentImage.date!.year.toString()}/${currentImage.date!.month.toString().padLeft(2, '0')}/${currentImage.date!.day.toString().padLeft(2, '0')}';
    return Image.network(
      'https://epic.gsfc.nasa.gov/archive/natural/$convertedDateTime/png/${currentImage.image}.png',
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
