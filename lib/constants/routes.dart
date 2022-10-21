import 'package:get/get.dart';
import 'package:weather_app/screens/cities_screen.dart';
import 'package:weather_app/screens/main_screen.dart';

class Routes {
  static const String main = '/main';
  static const String cities = '/cities';

  static List<GetPage> getRoutes() => [
        GetPage(name: Routes.main, page: () => const MainScreen()),
        GetPage(name: Routes.cities, page: () => const CitiesScreen()),
      ];
}
