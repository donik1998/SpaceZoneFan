import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spacefanzone/data/models/apod_model.dart';
import 'package:spacefanzone/data/services/apod_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class APOD extends StatefulWidget {
  @override
  _APODState createState() => _APODState();
}

class _APODState extends State<APOD> {
  APODModel? _apod;

  @override
  void initState() {
    ApodService.getPictureOfDay()
      ..then((apod) => {
            if (apod is APODModel)
              setState(() {
                _apod = apod;
              })
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _apod == null
        ? Center(
            child: FlareActor(
              'assets/images/LiquidLoad.flr',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: 'Loading',
            ),
          )
        : Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: _apod!.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nby\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                          TextSpan(
                            text: _apod!.copyright != null ? _apod!.copyright : 'Anonymous',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _apod!.mediaType == 'image'
                      ? Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Image.network(
                            _apod!.url!,
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
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: WebView(
                            initialUrl: _apod!.url,
                            gestureRecognizers: Set()
                              ..add(Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()))
                              ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _apod!.explanation!,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
