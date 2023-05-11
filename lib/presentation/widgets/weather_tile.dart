import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/forecast_model.dart';
import 'package:weather_app/presentation/widgets/date_weather_tile.dart';

class WeatherTile extends StatelessWidget {
  final ForecastModel data;

  String get _url => 'https://openweathermap.org/img/wn/${data.iconId!}@4x.png';
  String _temperatureFormat(double temperature) =>
      (temperature > 0 ? '+' : '') + temperature.toStringAsFixed(1);

  const WeatherTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DateWeatherTile(date: data.dateTime!),
          SizedBox.square(
            dimension: 225,
            child: Stack(
              children: [_image(), _temperatureInfo()],
            ),
          )
        ],
      ),
    );
  }

  Widget _image() => Positioned(
      left: 0,
      top: 0,
      child: SizedBox.square(
        dimension: 200,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: _url,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ));

  Widget _temperatureInfo() => Positioned(
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _temperatureFormat(data.maxTemperature!),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Text(
            _temperatureFormat(data.minTemperature!),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 26),
          )
        ],
      ));
}
