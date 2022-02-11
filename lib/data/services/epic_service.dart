import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spacefanzone/data/models/epic_image_model.dart';
import 'package:spacefanzone/tools/no_such_date_dialog.dart';

class EPICAPIService {
  static Future<List<EpicImageModel>> getImages() async {
    try {
      final Response response = await get(Uri.parse('https://epic.gsfc.nasa.gov/api/images.php'));
      if (response.statusCode == 200) {
        return epicImageFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<EpicImageModel>> getImagesToDate(DateTime date, BuildContext context) async {
    String formattedDate = '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    try {
      final Response response = await get(Uri.parse('https://epic.gsfc.nasa.gov/api/natural/date/$formattedDate'));
      if (await _dateIsAvailable(formattedDate)) {
        if (response.statusCode == 200) {
          return epicImageFromJson(response.body);
        } else {
          return [];
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
            pageBuilder: (context, animation1, animation2) {} as Widget Function(BuildContext, Animation<double>, Animation<double>));
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<bool> _dateIsAvailable(String formattedDate) async {
    try {
      final Response response = await get(Uri.parse('https://epic.gsfc.nasa.gov/api/natural/available'));
      if (response.statusCode == 200) {
        List<DateTime> dates = datesAvailableFromJson(response.body);
        if (dates.contains(DateTime.parse(formattedDate))) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

List<DateTime> datesAvailableFromJson(String str) => List<DateTime>.from(json.decode(str).map((x) => DateTime.parse(x)));

List<EpicImageModel> epicImageFromJson(String str) => List<EpicImageModel>.from(
      json.decode(str).map((x) => EpicImageModel.fromJson(x)),
    );
