import 'package:weather_app/domain/models/city_model.dart';

abstract class ICityRepository {
  Future<List<CityModel>> findByName(String name);
  Future<List<CityModel>> getAll();
  Future<int> getLastCityId();
  Future<void> saveCities(List<CityModel> items);
  Future<void> saveLastCityId(CityModel item);
}
