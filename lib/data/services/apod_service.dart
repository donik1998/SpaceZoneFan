import 'package:dio/dio.dart';
import 'package:space_fun_zone/data/api/api_client.dart';
import 'package:space_fun_zone/tools/constants.dart';

abstract class _ApodRepository {
  Future<dynamic> getPictureOfDay();
}

class ApodService implements _ApodRepository {
  ApodService._();

  static ApodService get instance => ApodService._();

  final Apis _client = Apis(Dio(), CancelToken());

  @override
  Future<dynamic> getPictureOfDay() async {
    try {
      final response = await _client.getAPOD(Constants.API_KEY);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
}
