import 'package:dio/dio.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/utils/constants/api_constants.dart';

class CityApiProvider {
  final Dio _dio = Dio();

  Future<List<CityModel>> findByName(String name) async {
    var response = await _dio.request(ApiConstants.openWeatherFindUrl,
        queryParameters: {
          'appid': ApiConstants.openWeatherWebToken,
          'q': name
        });

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
