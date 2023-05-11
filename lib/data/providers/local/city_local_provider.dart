import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/domain/models/city_model.dart';

class CityLocalProvider {
  final _box = GetStorage();

  static const _keyOfCities = 'cities';
  static const _keyOfLastCityId = 'last_city_id';

  Future<List<CityModel>> getAll() async {
    var result = <CityModel>[];
    var rawJson = _box.read(_keyOfCities);

    if (rawJson != null) {
      var decoded = jsonDecode(rawJson);
      for (var item in decoded) {
        result.add(Mapper.fromJson(item).toObject<CityModel>()!);
      }
    }

    return result;
  }

  Future<int?> getLastCityId() async {
    return _box.read(_keyOfLastCityId);
  }

  Future<void> saveCities(List<CityModel> items) async {
    var json = jsonEncode(items);
    await _box.write(_keyOfCities, json);
  }

  Future<void> saveLastCityId(CityModel item) async {
    await _box.write(_keyOfLastCityId, item.id);
  }
}
