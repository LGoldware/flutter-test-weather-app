import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/domain/repositories/i_city_repository.dart';
import 'package:weather_app/data/providers/remote/city_api_provider.dart';
import 'package:weather_app/data/providers/local/city_local_provider.dart';

class CityRepository implements ICityRepository {
  late final CityLocalProvider _cityLocalProvider;
  late final CityApiProvider _cityApiProvider;

  final _default = <CityModel>[
    CityModel()
      ..id = 625144
      ..name = 'Minsk'
      ..country = 'BY',
    CityModel()
      ..id = 629634
      ..name = 'Brest'
      ..country = 'BY',
    CityModel()
      ..id = 524901
      ..name = 'Moscow'
      ..country = 'RU',
  ];

  CityRepository() {
    _cityLocalProvider = CityLocalProvider();
    _cityApiProvider = CityApiProvider();
  }

  @override
  Future<List<CityModel>> findByName(String name) {
    return _cityApiProvider.findByName(name);
  }

  @override
  Future<List<CityModel>> getAll() async {
    var result = await _cityLocalProvider.getAll();

    if (result.isEmpty) {
      result.addAll(_default);
      saveCities(result);
    }

    return result;
  }

  @override
  Future<int> getLastCityId() async {
    var id = await _cityLocalProvider.getLastCityId();
    return id ?? _default.first.id!;
  }

  @override
  Future<void> saveCities(List<CityModel> items) async {
    await _cityLocalProvider.saveCities(items);
  }

  @override
  Future<void> saveLastCityId(CityModel item) async {
    await _cityLocalProvider.saveLastCityId(item);
  }
}
