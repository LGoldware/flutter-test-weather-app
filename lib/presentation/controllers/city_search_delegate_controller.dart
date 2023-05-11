import 'package:get/get.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/domain/repositories/i_city_repository.dart';

class CitySearchDelegateController extends GetxController {
  final ICityRepository _cityRepository = Get.find();

  final searchResult = <CityModel>[].obs;
  final _cities = <CityModel>[];

  @override
  void onReady() async {
    super.onReady();
    _cities.addAll(await _cityRepository.getAll());
  }

  Future<void> findByName(String name) async {
    searchResult.value = await _cityRepository.findByName(name);
  }

  Future<bool> addCity(CityModel item) async {
    var result = !_cities.contains(item);

    if (result) {
      _cities.add(item);
      await _cityRepository.saveCities(_cities);
    }

    return result;
  }
}
