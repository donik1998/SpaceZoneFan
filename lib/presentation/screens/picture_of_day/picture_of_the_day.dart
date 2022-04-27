import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space_fun_zone/presentation/screens/picture_of_day/picture_of_day_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class APOD extends StatelessWidget {
  const APOD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PictureOfDayProvider>(
      builder: (context, state, child) {
        if (state.isLoading) {
          return const Center(
            child: FlareActor(
              'assets/images/LiquidLoad.flr',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: 'Loading',
            ),
          );
        } else {
          return SingleChildScrollView(
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
                      text: state.apod!.title,
                      style: const TextStyle(color: Colors.white, fontSize: 28.0),
                      children: <TextSpan>[
                        const TextSpan(
                          text: '\nby\n',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                        TextSpan(
                          text: state.apod?.copyright != null ? state.apod!.copyright : 'Anonymous',
                          style: const TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(state.apod!.date!),
                          style: const TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (state.apod?.mediaType == 'image')
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: state.apod!.url!,
                      progressIndicatorBuilder: (context, url, progress) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                if (state.apod?.mediaType != 'image')
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: WebView(
                      initialUrl: state.apod!.url,
                      gestureRecognizers: {}
                        ..add(Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    state.apod!.explanation!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
