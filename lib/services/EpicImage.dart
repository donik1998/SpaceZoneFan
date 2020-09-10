import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spacefanzone/tools/NoSuchDate.dart';

class EPICapiService {
  static Future<List<EpicImage>> getImages() async {
    try {
      final Response response =
          await get('https://epic.gsfc.nasa.gov/api/images.php');
      if (response.statusCode == 200) {
        return epicImageFromJson(response.body);
      } else {
        return List<EpicImage>();
      }
    } catch (e) {
      return List<EpicImage>();
    }
  }

  static Future<List<EpicImage>> getImagesToDate(
      DateTime date, BuildContext context) async {
    String formattedDate =
        '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    try {
      final Response response = await get(
          'https://epic.gsfc.nasa.gov/api/natural/date/$formattedDate');
      if (await _dateIsAvalable(formattedDate)) {
        if (response.statusCode == 200) {
          return epicImageFromJson(response.body);
        } else {
          return List<EpicImage>();
        }
      } else {
        showGeneralDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 500),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                alignment: Alignment.center,
                child: Opacity(
                  opacity: a1.value,
                  child: NoSuchDateError(),
                ),
              );
            },
            pageBuilder: (context, animation1, animation2) {});
        return List<EpicImage>();
      }
    } catch (e) {
      return List<EpicImage>();
    }
  }

  static Future<bool> _dateIsAvalable(String formattedDate) async {
    try {
      final Response response =
          await get('https://epic.gsfc.nasa.gov/api/natural/available');
      if (response.statusCode == 200) {
        List<DateTime> dates = datesAvailableFromJson(response.body);
        if (dates.contains(DateTime.parse(formattedDate))) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }
}

List<DateTime> datesAvailableFromJson(String str) =>
    List<DateTime>.from(json.decode(str).map((x) => DateTime.parse(x)));

List<EpicImage> epicImageFromJson(String str) =>
    List<EpicImage>.from(json.decode(str).map((x) => EpicImage.fromJson(x)));

class EpicImage {
  EpicImage({
    this.caption,
    this.image,
    this.date,
  });

  String caption;
  String image;
  DateTime date;

  factory EpicImage.fromJson(Map<String, dynamic> json) => EpicImage(
        caption: json["caption"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
      );
}
