import "dart:math";
import 'package:weather_app/extensions/datetime_extension.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/providers/api/weather_api_provider.dart';
import 'package:weather_app/providers/local/weather_local_provider.dart';

class WeatherRepository {
  late final WeatherApiProvider _weatherApiProvider;
  late final WeatherLocalProvider _weatherLocalProvider;

  WeatherRepository() {
    _weatherApiProvider = WeatherApiProvider();
    _weatherLocalProvider = WeatherLocalProvider();
  }

  Future<ForecastModel?> getCurrentWeatherFromStorage(int cityId) {
    return _weatherLocalProvider.getCurrentWeather(cityId);
  }

  Future<ForecastModel?> getCurrentWeatherFromApi(int cityId) async {
    var result = await _weatherApiProvider.getCurrentWeather(cityId);

    if (result != null) {
      saveCurrentWeather(cityId, result);
    }

    return result;
  }

  Future<List<ForecastModel>> getForecastWeatherFromStorage(int cityId) {
    return _weatherLocalProvider.getForecastWeather(cityId);
  }

  Future<List<ForecastModel>> getForecastWeatherFromApi(
      {required int cityId, required int countOfDays}) async {
    var result = <ForecastModel>[];
    var countofMarks = 8 * countOfDays + _countMarksOfCurrentDay();

    var rawList = await _weatherApiProvider.getForecastWeather(
        cityId: cityId, countOfMarks: countofMarks);
    rawList.removeWhere((element) => element.dateTime?.isToday ?? true);

    var uniqueDates = rawList.map((item) => item.dateTime!.date).toSet();
    for (var item in uniqueDates) {
      var weatherFromDate =
          rawList.where((element) => element.dateTime!.date == item);

      result.add(ForecastModel()
        ..dateTime = item
        ..maxTemperature =
            weatherFromDate.map((item) => item.maxTemperature!).reduce(max)
        ..minTemperature =
            weatherFromDate.map((item) => item.minTemperature!).reduce(min)
        ..iconId = weatherFromDate
            .firstWhere((element) => element.dateTime!.hour == 12)
            .iconId);
    }

    saveForecastWeather(cityId, result);

    return result;
  }

  Future<void> saveCurrentWeather(int cityId, ForecastModel item) async {
    _weatherLocalProvider.saveCurrentWeather(cityId, item);
  }

  Future<void> saveForecastWeather(
      int cityId, List<ForecastModel> items) async {
    _weatherLocalProvider.saveForecastWeather(cityId, items);
  }

  Future<void> removeAllDataByCityId(int cityId) async {
    _weatherLocalProvider.removeAllDataByCityId(cityId);
  }

  int _countMarksOfCurrentDay() => ((24 - DateTime.now().hour) / 3).ceil();
}
