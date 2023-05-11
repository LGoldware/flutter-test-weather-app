import 'package:object_mapper/object_mapper.dart';

class ForecastModel with Mappable {
  DateTime? dateTime;
  String? iconId;
  double? minTemperature;
  double? maxTemperature;

  @override
  void mapping(Mapper map) {
    map("dt_txt", dateTime, (v) => dateTime = v ?? DateTime.now(),
        const DateTransform());
    map("main.temp_min", minTemperature,
        (v) => minTemperature = v is int ? v.toDouble() : v);
    map("main.temp_max", maxTemperature,
        (v) => maxTemperature = v is int ? v.toDouble() : v);
    map("weather", iconId, (v) => iconId = (v is List) ? v.first['icon'] : v);
  }
}
