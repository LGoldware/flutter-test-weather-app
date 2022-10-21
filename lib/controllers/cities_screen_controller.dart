import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/repositories/city_repository.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/screens/delegates/city_search_delegate.dart';
import 'package:flutter/material.dart';

class CitiesScreenController extends GetxController {
  final CityRepository _cityRepository = Get.find();
  final WeatherRepository _weatherRepository = Get.find();

  final cities = <CityModel>[].obs;

  @override
  void onReady() async {
    super.onReady();
    cities.value = await _cityRepository.getAll();
  }

  void removeCity(CityModel item) async {
    if (cities.length != 1) {
      cities.remove(item);
      _weatherRepository.removeAllDataByCityId(item.id!);
      _cityRepository.saveCities(cities);

      var selectable = await _cityRepository.getLastCityId();
      if (item.id! == selectable) {
        var newLastItem = cities[0];
        await _cityRepository.saveLastCityId(newLastItem);
      }
    } else {
      Fluttertoast.showToast(msg: "Список не может быть пуст!");
    }
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
