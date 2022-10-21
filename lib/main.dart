import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/constants/routes.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/utills/bindings.dart';

void main() async {
  Intl.defaultLocale = 'ru_RU';
  await initializeDateFormatting();

  await GetStorage.init();

  Mappable.factories = {
    ForecastModel: () => ForecastModel(),
    CityModel: () => CityModel()
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
