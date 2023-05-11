import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/config/routes.dart';
import 'package:weather_app/presentation/controllers/main_screen_controller.dart';
import 'package:weather_app/domain/models/city_model.dart';
import 'package:weather_app/presentation/widgets/weather_tile.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentCity(),
        actions: [
          PopupMenuButton<CityModel>(
              icon: const Icon(Icons.expand_more),
              onSelected: controller.setCity,
              itemBuilder: (context) => _citiesList()),
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () =>
                  Get.toNamed(Routes.cities)?.then(controller.onReturn)),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: orientation == Orientation.portrait
              ? _portraitBody()
              : _landscapeBody(),
        );
      },
    );
  }

  Widget _portraitBody() {
    return Column(
      children: [
        Expanded(child: _currentWeather()),
        Obx(() => Row(
              children: _forecastWeather(),
            ))
      ],
    );
  }

  Widget _landscapeBody() {
    return Row(children: [
      _currentWeather(),
      Flexible(
          child: Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: _forecastWeather(),
              )))
    ]);
  }

  Widget _currentWeather() => Obx(() {
        if (controller.currentWeather.value != null) {
          return WeatherTile(data: controller.currentWeather.value!);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  List<Widget> _forecastWeather() {
    var result = <Widget>[];

    for (var data in controller.forecastWeather) {
      result.add(Flexible(child: WeatherTile(data: data)));
    }

    return result;
  }

  Widget _currentCity() => Obx(() {
        if (controller.selectedCity.value != null) {
          return Text(controller.selectedCity.value!.fullName);
        }

        return const Text("Loading..");
      });
  List<PopupMenuEntry<CityModel>> _citiesList() {
    var result = <PopupMenuEntry<CityModel>>[];

    for (var city in controller.observableCities) {
      result.add(PopupMenuItem(
        value: city,
        child: Text(city.fullName),
      ));
    }

    return result;
  }
}
