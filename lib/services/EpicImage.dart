import 'dart:convert';

import 'package:http/http.dart';

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
}

// To parse this JSON data, do
//
//     final epicImage = epicImageFromJson(jsonString);

List<EpicImage> epicImageFromJson(String str) =>
    List<EpicImage>.from(json.decode(str).map((x) => EpicImage.fromJson(x)));

String epicImageToJson(List<EpicImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
