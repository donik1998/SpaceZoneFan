import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spacefanzone/services/EpicImage.dart';

class EPIC extends StatefulWidget {
  @override
  _EPICState createState() => _EPICState();
}

class _EPICState extends State<EPIC> {
  EPICapiService _epicService;
  List<EpicImage> _images;

  @override
  void initState() {
    super.initState();
    EPICapiService.getImages()..then((images) => {_images = images});
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
            onPressed: () {},
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
                fontFamily: 'Overpass-Regular',
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: _epicService == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(itemBuilder: (context, index) {
                    EpicImage image = _images[index];
                    return null;
                    //todo implement actual images
                  }),
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

  getRecentPhotos() async {
    Response response = await get('https://epic.gsfc.nasa.gov/api/images.php');
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      return '';
    }
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
