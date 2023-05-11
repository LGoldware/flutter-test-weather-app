import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_app/config/routes.dart';
import 'package:weather_app/utils/init_bindings.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      initialRoute: Routes.main,
      initialBinding: InitialBindings(),
      getPages: Routes.getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
