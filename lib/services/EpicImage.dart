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
    this.identifier,
    this.caption,
    this.image,
    this.version,
    this.centroidCoordinates,
    this.dscovrJ2000Position,
    this.lunarJ2000Position,
    this.sunJ2000Position,
    this.attitudeQuaternions,
    this.date,
    this.coords,
  });

  String identifier;
  String caption;
  String image;
  String version;
  CentroidCoordinates centroidCoordinates;
  J2000Position dscovrJ2000Position;
  J2000Position lunarJ2000Position;
  J2000Position sunJ2000Position;
  AttitudeQuaternions attitudeQuaternions;
  DateTime date;
  Coords coords;

  factory EpicImage.fromJson(Map<String, dynamic> json) => EpicImage(
        identifier: json["identifier"],
        caption: json["caption"],
        image: json["image"],
        version: json["version"],
        centroidCoordinates:
            CentroidCoordinates.fromJson(json["centroid_coordinates"]),
        dscovrJ2000Position:
            J2000Position.fromJson(json["dscovr_j2000_position"]),
        lunarJ2000Position:
            J2000Position.fromJson(json["lunar_j2000_position"]),
        sunJ2000Position: J2000Position.fromJson(json["sun_j2000_position"]),
        attitudeQuaternions:
            AttitudeQuaternions.fromJson(json["attitude_quaternions"]),
        date: DateTime.parse(json["date"]),
        coords: Coords.fromJson(json["coords"]),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "caption": caption,
        "image": image,
        "version": version,
        "centroid_coordinates": centroidCoordinates.toJson(),
        "dscovr_j2000_position": dscovrJ2000Position.toJson(),
        "lunar_j2000_position": lunarJ2000Position.toJson(),
        "sun_j2000_position": sunJ2000Position.toJson(),
        "attitude_quaternions": attitudeQuaternions.toJson(),
        "date": date.toIso8601String(),
        "coords": coords.toJson(),
      };
}

class AttitudeQuaternions {
  AttitudeQuaternions({
    this.q0,
    this.q1,
    this.q2,
    this.q3,
  });

  double q0;
  double q1;
  double q2;
  double q3;

  factory AttitudeQuaternions.fromJson(Map<String, dynamic> json) =>
      AttitudeQuaternions(
        q0: json["q0"].toDouble(),
        q1: json["q1"].toDouble(),
        q2: json["q2"].toDouble(),
        q3: json["q3"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "q0": q0,
        "q1": q1,
        "q2": q2,
        "q3": q3,
      };
}

class CentroidCoordinates {
  CentroidCoordinates({
    this.lat,
    this.lon,
  });

  double lat;
  double lon;

  factory CentroidCoordinates.fromJson(Map<String, dynamic> json) =>
      CentroidCoordinates(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Coords {
  Coords({
    this.centroidCoordinates,
    this.dscovrJ2000Position,
    this.lunarJ2000Position,
    this.sunJ2000Position,
    this.attitudeQuaternions,
  });

  CentroidCoordinates centroidCoordinates;
  J2000Position dscovrJ2000Position;
  J2000Position lunarJ2000Position;
  J2000Position sunJ2000Position;
  AttitudeQuaternions attitudeQuaternions;

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        centroidCoordinates:
            CentroidCoordinates.fromJson(json["centroid_coordinates"]),
        dscovrJ2000Position:
            J2000Position.fromJson(json["dscovr_j2000_position"]),
        lunarJ2000Position:
            J2000Position.fromJson(json["lunar_j2000_position"]),
        sunJ2000Position: J2000Position.fromJson(json["sun_j2000_position"]),
        attitudeQuaternions:
            AttitudeQuaternions.fromJson(json["attitude_quaternions"]),
      );

  Map<String, dynamic> toJson() => {
        "centroid_coordinates": centroidCoordinates.toJson(),
        "dscovr_j2000_position": dscovrJ2000Position.toJson(),
        "lunar_j2000_position": lunarJ2000Position.toJson(),
        "sun_j2000_position": sunJ2000Position.toJson(),
        "attitude_quaternions": attitudeQuaternions.toJson(),
      };
}

class J2000Position {
  J2000Position({
    this.x,
    this.y,
    this.z,
  });

  double x;
  double y;
  double z;

  factory J2000Position.fromJson(Map<String, dynamic> json) => J2000Position(
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
        z: json["z"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };
}
