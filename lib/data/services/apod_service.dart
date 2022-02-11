import 'dart:convert';

import 'package:http/http.dart';
import 'package:spacefanzone/data/models/apod_model.dart';

class ApodService {
  ApodService._();

  static Future<dynamic> getPictureOfDay() async {
    Response response = await get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=r7aoIse2731GHse708W49A8NAPakt4fDJxmklqV1'));
    if (response.statusCode == 200) {
      return APODModel.fromJson(jsonDecode(response.body));
    }
  }
}
