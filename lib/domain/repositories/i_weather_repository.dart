import 'package:weather_app/domain/models/forecast_model.dart';

abstract class IWeatherRepository {
  Future<ForecastModel?> getCurrentWeatherFromStorage(int cityId);
  Future<ForecastModel?> getCurrentWeatherFromApi(int cityId);
  Future<List<ForecastModel>> getForecastWeatherFromStorage(int cityId);
  Future<List<ForecastModel>> getForecastWeatherFromApi(
      {required int cityId, required int countOfDays});
  Future<void> saveCurrentWeather(int cityId, ForecastModel item);
  Future<void> saveForecastWeather(int cityId, List<ForecastModel> items);
  Future<void> removeAllDataByCityId(int cityId);
}
