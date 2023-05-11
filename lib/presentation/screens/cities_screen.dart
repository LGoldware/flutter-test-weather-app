import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:weather_app/presentation/controllers/cities_screen_controller.dart';

class CitiesScreen extends GetView<CitiesScreenController> {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of cities"),
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
                onPressed: () async {
                  var result = await controller.removeCity(item);
                  if (!result) {
                    Fluttertoast.showToast(msg: "List can't empty!");
                  }
                },
              ),
            );
          },
        ));
  }
}
