import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/cities_screen_controller.dart';

class CitiesScreen extends GetView<CitiesScreenController> {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список городов"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.callSearchDelegate(context),
        child: const Icon(Icons.search),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(() => ListView.builder(
          itemCount: controller.cities.length,
          itemBuilder: (context, index) {
            var item = controller.cities[index];
            return ListTile(
              title: Text(item.name!),
              subtitle: Text(item.country!),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.removeCity(item),
              ),
            );
          },
        ));
  }
}
