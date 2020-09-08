import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:spacefanzone/services/EpicImage.dart';

class EPIC extends StatefulWidget {
  @override
  _EPICState createState() => _EPICState();
}

class _EPICState extends State<EPIC> {
  List<EpicImage> _images = List<EpicImage>();

  @override
  void initState() {
    super.initState();
    EPICapiService.getImages()
      ..then((images) => {
            setState(() {
              _images = images;
            })
          });
  }

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
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: _buildItem(_images[index]),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
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
    return _pickedDate;
  }

  Widget _buildItem(EpicImage currentImage) {
    String convertedDateTime =
        '${currentImage.date.year.toString()}/${currentImage.date.month.toString().padLeft(2, '0')}/${currentImage.date.day.toString().padLeft(2, '0')}';
    return Image.network(
      'https://epic.gsfc.nasa.gov/archive/natural/$convertedDateTime/png/${currentImage.image}.png',
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
      // loadingBuilder: (BuildContext context, Widget child,
      //     ImageChunkEvent loadingProgress) {
      //   if (loadingProgress == null) return child;
      //   return Center(
      //
      //   );
      // },
    );
  }
}

// class EpicImage {
//   final String image, caption;
//   final DateTime date;
//
//   EpicImage({this.image, this.caption, this.date});
//
//   factory EpicImage.fromJson(Map<String, dynamic> jsonData) {
//     return EpicImage(
//       image: jsonData['image'],
//       caption: jsonData['caption'],
//       date: DateTime.parse(
//         jsonData['date'],
//       ),
//     );
//   }
// }
