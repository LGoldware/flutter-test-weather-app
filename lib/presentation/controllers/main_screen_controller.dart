import 'dart:async';

import 'package:get/get.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/domain/models/forecast_model.dart';
import 'package:weather_app/domain/repositories/i_city_repository.dart';
import 'package:weather_app/domain/repositories/i_weather_repository.dart';
import 'package:weather_app/utils/extensions/datetime_extension.dart';

class MainScreenController extends GetxController {
  final IWeatherRepository _weatherRepository = Get.find();
  final ICityRepository _cityRepository = Get.find();

  final currentWeather = Rxn<ForecastModel>();
  final forecastWeather = <ForecastModel>[].obs;
  final selectedCity = Rxn<CityModel>();
  final observableCities = <CityModel>[].obs;

  static const _countOfDays = 3;

  late StreamSubscription _selectedCityListener;

  void onReturn(result) async {
    observableCities.clear();
    observableCities.addAll(await _cityRepository.getAll());

    _loadLastCity();
  }

  @override
  void onInit() async {
    observableCities.value = await _cityRepository.getAll();

    _selectedCityListener = selectedCity.listen((city) {
      currentWeather.value = null;
      forecastWeather.clear();

      if (city != null) {
        _loadCurrentWeatherData(city.id!);
        _loadForecastData(city.id!);
      }
    });
    await _loadLastCity();

    super.onInit();
  }

  @override
  void onClose() {
    _selectedCityListener.cancel();
    super.onClose();
  }

  void setCity(CityModel city) {
    selectedCity.value = city;
    _cityRepository.saveLastCityId(city);
  }

  void _loadCurrentWeatherData(int cityId) async {
    var data = await _weatherRepository.getCurrentWeatherFromStorage(cityId);

    if (data == null || data.dateTime!.calculateDifferenceInMinutes > 3) {
      data = await _weatherRepository.getCurrentWeatherFromApi(cityId);
    }

    currentWeather.value = data;
  }

  void _loadForecastData(int cityId) async {
    var data = await _weatherRepository.getForecastWeatherFromStorage(cityId);

    DateTime now = DateTime.now();
    var futureDay = DateTime(now.year, now.month, now.day + _countOfDays);
    var dates = data.map((item) => item.dateTime!.date);

    if (!dates.contains(futureDay)) {
      data = await _weatherRepository.getForecastWeatherFromApi(
          cityId: cityId, countOfDays: _countOfDays);
    }

    forecastWeather.value = data;
  }

  Future<void> _loadLastCity() async {
    var lastCityId = await _cityRepository.getLastCityId();
    selectedCity.value =
        observableCities.firstWhere((element) => element.id == lastCityId);
  }
}
