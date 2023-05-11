import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:weather_app/presentation/controllers/city_search_delegate_controller.dart';
import 'package:weather_app/domain/models/city_model.dart';

class CitySearchDelegate extends SearchDelegate {
  final _controller = Get.find<CitySearchDelegateController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, false);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, false),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: _controller.searchResult.length,
        itemBuilder: (context, index) {
          var item = _controller.searchResult[index];
          return ListTile(
              title: Text(item.name!),
              subtitle: Text(item.country!),
              onTap: () => _addCity(context, item));
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty && query.length < 3) {
      _controller.searchResult.clear();
    } else if (query.length > 2) {
      _controller.findByName(query);
    }

    return Obx(() => ListView.builder(
        itemCount: _controller.searchResult.length,
        itemBuilder: (context, index) {
          var item = _controller.searchResult[index];
          return ListTile(
              title: Text(item.name!),
              subtitle: Text(item.country!),
              onTap: () => _addCity(context, item));
        }));
  }

  Future<bool> _addCity(BuildContext context, CityModel item) async {
    final result = await _controller.addCity(item);
    if (result) {
      Fluttertoast.showToast(msg: "City has been added");

      if (context.mounted) {
        close(context, result);
      }
    } else {
      Fluttertoast.showToast(msg: "Already exist");
    }

    return result;
  }
}
