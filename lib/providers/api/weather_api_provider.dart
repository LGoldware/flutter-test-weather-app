import 'package:dio/dio.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/utills/settings.dart';

class WeatherApiProvider {
  final Dio _dio = Dio();
  final String _currentWeatherPath = 'weather';
  final String _forecastWeatherPath = 'forecast';

  Future<ForecastModel?> getCurrentWeather(int cityId) async {
    var url = AppSettings.openWeatherApiUrl + _currentWeatherPath;
    var response = await _dio.request(url, queryParameters: {
      'appid': AppSettings.openWeatherAppToken,
      'id': cityId,
      'units': 'metric',
    });

    if (response.statusCode == 200) {
      return Mapper.fromJson(response.data).toObject<ForecastModel>();
    }

    return null;
  }

  Future<List<ForecastModel>> getForecastWeather(
      {required int cityId, required int countOfMarks}) async {
    var url = AppSettings.openWeatherApiUrl + _forecastWeatherPath;
    var response = await _dio.request(url, queryParameters: {
      'appid': AppSettings.openWeatherAppToken,
      'id': cityId,
      'cnt': countOfMarks,
      'units': 'metric',
    });

    var result = <ForecastModel>[];
    if (response.statusCode == 200) {
      for (var item in response.data['list']) {
        result.add(Mapper.fromJson(item).toObject<ForecastModel>()!);
      }
    }

    return result;
  }
}
