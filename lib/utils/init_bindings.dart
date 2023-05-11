import 'package:get/get.dart';
import 'package:weather_app/data/repositories/city_repository.dart';
import 'package:weather_app/domain/repositories/i_city_repository.dart';
import 'package:weather_app/domain/repositories/i_weather_repository.dart';
import 'package:weather_app/presentation/controllers/cities_screen_controller.dart';
import 'package:weather_app/presentation/controllers/main_screen_controller.dart';
import 'package:weather_app/presentation/controllers/city_search_delegate_controller.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    _initRepositories();
    _initControllers();
  }

  void _initRepositories() {
    Get.lazyPut<IWeatherRepository>(() => WeatherRepository(), fenix: true);
    Get.lazyPut<ICityRepository>(() => CityRepository(), fenix: true);
  }

  void _initControllers() {
    Get.lazyPut<MainScreenController>(() => MainScreenController(),
        fenix: true);
    Get.lazyPut<CitiesScreenController>(() => CitiesScreenController(),
        fenix: true);
    Get.lazyPut<CitySearchDelegateController>(
        () => CitySearchDelegateController(),
        fenix: true);
  }
}
