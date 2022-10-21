import 'package:get/get.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/repositories/city_repository.dart';

class CitySearchDelegateController extends GetxController {
  final CityRepository _cityRepository = Get.find();

  final searchResult = <CityModel>[].obs;
  final _cities = <CityModel>[];

  @override
  void onReady() async {
    super.onReady();
    _cities.addAll(await _cityRepository.getAll());
  }

  void findByName(String name) async {
    searchResult.value = await _cityRepository.findByName(name);
  }

  bool addCity(CityModel item) {
    var result = !_cities.contains(item);

    if (result) {
      _cities.add(item);
      _cityRepository.saveCities(_cities);
    }

    return result;
  }
}
