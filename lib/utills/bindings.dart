import 'package:get/get.dart';
import 'package:weather_app/controllers/cities_screen_controller.dart';
import 'package:weather_app/controllers/main_screen_controller.dart';
import 'package:weather_app/controllers/city_search_delegate_controller.dart';
import 'package:weather_app/repositories/city_repository.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    _initRepositories();
    _initControllers();
  }

  void _initRepositories() {
    Get.lazyPut<WeatherRepository>(() => WeatherRepository(), fenix: true);
    Get.lazyPut<CityRepository>(() => CityRepository(), fenix: true);
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
