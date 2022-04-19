import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:space_fun_zone/data/api/api_client.dart';
import 'package:space_fun_zone/data/models/epic_image_model.dart';

abstract class EPICRepository {
  Future<dynamic> getImages();
  Future<dynamic> getClosetsToDateImages(DateTime date);
}

class EPICAPIService extends EPICRepository {
  EPICAPIService._();

  static EPICAPIService get instance => EPICAPIService._();

  final client = Apis(Dio(), CancelToken(), baseUrl: 'https://epic.gsfc.nasa.gov');

  @override
  Future<dynamic> getImages() async {
    try {
      final images = await client.getEpicImage();
      return images;
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> _dateIsAvailable(String formattedDate) async {
    // try {
    //   final Response response = await get(Uri.parse('https://epic.gsfc.nasa.gov/api/natural/available'));
    //   if (response.statusCode == 200) {
    //     List<DateTime> dates = datesAvailableFromJson(response.body);
    //     if (dates.contains(DateTime.parse(formattedDate))) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   }
    //   return false;
    // } catch (e) {
    //   return false;
    // }
    return false;
  }

  @override
  Future<dynamic> getClosetsToDateImages(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final images = await client.getClosetsToDateImages(formattedDate);
    return images;
  }
}

List<DateTime> datesAvailableFromJson(String str) => List<DateTime>.from(json.decode(str).map((x) => DateTime.parse(x)));

List<EpicImageModel> epicImageFromJson(String str) =>
    List<EpicImageModel>.from(json.decode(str).map((x) => EpicImageModel.fromJson(x)));
