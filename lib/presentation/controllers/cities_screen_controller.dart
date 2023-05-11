import 'package:get/get.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/domain/repositories/i_city_repository.dart';
import 'package:weather_app/domain/repositories/i_weather_repository.dart';
import 'package:weather_app/presentation/screens/delegates/city_search_delegate.dart';
import 'package:flutter/material.dart';

class CitiesScreenController extends GetxController {
  final ICityRepository _cityRepository = Get.find();
  final IWeatherRepository _weatherRepository = Get.find();

  final cities = <CityModel>[].obs;

  @override
  void onReady() async {
    super.onReady();
    cities.value = await _cityRepository.getAll();
  }

  Future<bool> removeCity(CityModel item) async {
    if (cities.length <= 1) {
      return false;
    }

    cities.remove(item);
    _weatherRepository.removeAllDataByCityId(item.id!);
    _cityRepository.saveCities(cities);

    var selectable = await _cityRepository.getLastCityId();
    if (item.id! == selectable) {
      var newLastItem = cities.first;
      await _cityRepository.saveLastCityId(newLastItem);
    }

    return true;
  }

  void callSearchDelegate(BuildContext context) async {
    var result =
        await showSearch(context: context, delegate: CitySearchDelegate());
    if (result) {
      cities.clear();
      cities.value = await _cityRepository.getAll();
    }
  }
}
