import 'dart:convert';

import 'package:http/http.dart';

class ApodService {
  final String copyright, explanation, url, hdurl, mediaType, title;
  final DateTime date;

  ApodService(
      {this.copyright,
      this.explanation,
      this.url,
      this.hdurl,
      this.mediaType,
      this.title,
      this.date});

  factory ApodService.fromJson(Map<String, dynamic> jsonData) {
    return ApodService(
      copyright: jsonData['copyright'],
      date: DateTime.parse(jsonData['date']),
      explanation: jsonData['explanation'],
      hdurl: jsonData['hdurl'],
      url: jsonData['url'],
      mediaType: jsonData['media_type'],
      title: jsonData['title'],
    );
  }

  static Future<ApodService> getPictureOfDay() async {
    Response response = await get(
        'https://api.nasa.gov/planetary/apod?api_key=r7aoIse2731GHse708W49A8NAPakt4fDJxmklqV1&date=2020-09-01');
    if (response.statusCode == 200) {
      return ApodService.fromJson(jsonDecode(response.body));
    }
  }
}
