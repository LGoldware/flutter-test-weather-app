import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/domain/models/forecast_model.dart';

class WeatherLocalProvider {
  final _box = GetStorage();

  static const _currentSuffix = '_current';
  static const _forecastSuffix = '_forecast';

  Future<ForecastModel?> getCurrentWeather(int cityId) async {
    var key = cityId.toString() + _currentSuffix;
    var rawJson = _box.read(key);

    if (rawJson != null) {
      return Mapper.fromJson(jsonDecode(rawJson)).toObject<ForecastModel>();
    } else {
      return null;
    }
  }

  Future<List<ForecastModel>> getForecastWeather(int cityId) async {
    var result = <ForecastModel>[];
    var key = cityId.toString() + _forecastSuffix;
    var rawJson = _box.read(key);

    if (rawJson != null) {
      var decoded = jsonDecode(rawJson);
      for (var item in decoded) {
        result.add(Mapper.fromJson(item).toObject<ForecastModel>()!);
      }
    }

    return result;
  }

  Future<void> saveCurrentWeather(int cityId, ForecastModel item) async {
    var key = cityId.toString() + _currentSuffix;
    var json = jsonEncode(item);
    await _box.write(key, json);
  }

  Future<void> saveForecastWeather(
      int cityId, List<ForecastModel> items) async {
    var key = cityId.toString() + _forecastSuffix;
    var json = jsonEncode(items);
    await _box.write(key, json);
  }

  Future<void> removeAllDataByCityId(int cityId) async {
    var currentKey = cityId.toString() + _currentSuffix;
    var forecastKey = cityId.toString() + _forecastSuffix;

    await _box.remove(currentKey);
    await _box.remove(forecastKey);
  }
}
