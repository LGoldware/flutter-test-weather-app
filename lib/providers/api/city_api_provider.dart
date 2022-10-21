import 'package:dio/dio.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/utills/settings.dart';

class CityApiProvider {
  final Dio _dio = Dio();

  Future<List<CityModel>> findByName(String name) async {
    var response = await _dio.request(AppSettings.openWeatherFindUrl,
        queryParameters: {'appid': AppSettings.openWeatherWebToken, 'q': name});

    var result = <CityModel>[];
    if (response.statusCode == 200) {
      for (var item in response.data['list']) {
        var city = Mapper.fromJson(item).toObject<CityModel>()!;
        result.add(city);
      }
    }

    return result;
  }
}
