import 'dart:convert';

import 'package:http/http.dart';

class EPICapiQueryBuilder {
  final DateTime date;

  EPICapiQueryBuilder(this.date);

  Future<void> getPhotosOnDate() async {
    Response response = await get(
        'https://epic.gsfc.nasa.gov/api/enhanced/date/${date.year}-${date.month}-${date.day}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
