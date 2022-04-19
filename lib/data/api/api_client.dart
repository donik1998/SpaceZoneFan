import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:retrofit/http.dart';
import 'package:space_fun_zone/data/models/apod_model.dart';
import 'package:space_fun_zone/data/models/epic_image_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.nasa.gov')
abstract class Apis {
  factory Apis(Dio dio, CancelToken cancelToken, {String? baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    dio.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ));
    return _Apis(dio, baseUrl: baseUrl);
  }

  @GET('/planetary/apod')
  Future<APODModel?> getAPOD(
    @Query('api_key') String apiKey,
  );

  @GET('/api/images.php')
  Future<List<EpicImageModel>> getEpicImage();

  @GET('/api/natural/date/{date}')
  Future<List<EpicImageModel>> getClosetsToDateImages(
    @Path('date') String formattedDate,
  );
}
