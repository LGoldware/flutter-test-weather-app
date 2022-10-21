import 'dart:async';

import 'package:get/get.dart';
import 'package:weather_app/extensions/datetime_extension.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/repositories/city_repository.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class MainScreenController extends GetxController {
  final WeatherRepository _weatherRepository = Get.find();
  final CityRepository _cityRepository = Get.find();

  static const countOfDays = 3;

  final currentWeather = Rxn<ForecastModel>();
  final forecastWeather = <ForecastModel>[].obs;
  final selectedCity = Rxn<CityModel>();

  final observableCities = <CityModel>[].obs;

  late StreamSubscription _selectedCityListener;

  void onReturn(dynamic result) async {
    observableCities.clear();
    observableCities.addAll(await _cityRepository.getAll());

    _loadLastCity();
  }

  @override
  void onInit() async {
    observableCities.value = await _cityRepository.getAll();

    _selectedCityListener = selectedCity.listen((value) {
      currentWeather.value = null;
      forecastWeather.clear();

      _loadCurrentWeatherData();
      _loadForecastData();
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

  void _loadCurrentWeatherData() async {
    var data = await _weatherRepository
        .getCurrentWeatherFromStorage(selectedCity.value!.id!);

    if (data == null || data.dateTime!.calculateDifferenceInMinutes > 3) {
      data = await _weatherRepository
          .getCurrentWeatherFromApi(selectedCity.value!.id!);
    }

    currentWeather.value = data;
  }

  void _loadForecastData() async {
    var data = await _weatherRepository
        .getForecastWeatherFromStorage(selectedCity.value!.id!);

    DateTime now = DateTime.now();
    var futureDay = DateTime(now.year, now.month, now.day + countOfDays);
    var dates = data.map((item) => item.dateTime!.date);

    if (!dates.contains(futureDay)) {
      data = await _weatherRepository.getForecastWeatherFromApi(
          cityId: selectedCity.value!.id!, countOfDays: countOfDays);
    }

    forecastWeather.value = data;
  }

  Future<void> _loadLastCity() async {
    var lastCityId = await _cityRepository.getLastCityId();
    selectedCity.value =
        observableCities.firstWhere((element) => element.id == lastCityId);
  }
}
