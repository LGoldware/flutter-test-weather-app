import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/extensions/datetime_extension.dart';

class DateWeatherTile extends StatelessWidget {
  DateWeatherTile({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  final DateFormat _shortFormat = DateFormat('dd.MM');
  final DateFormat _longFormat = DateFormat('dd MMMM');

  DateFormat get _format => date.isToday ? _longFormat : _shortFormat;

  @override
  Widget build(BuildContext context) {
    return Text(
      _format.format(date),
      style: TextStyle(
        color: date.isWeekend ? Colors.redAccent : Colors.black,
        fontSize: 24,
      ),
    );
  }
}
