import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/domain/models/forecast_model.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  Intl.defaultLocale = 'en_US';
  await initializeDateFormatting();

  await GetStorage.init();

  Mappable.factories = {
    ForecastModel: () => ForecastModel(),
    CityModel: () => CityModel()
  };

  runApp(const WeatherApp());
}
