extension DateTimeExtension on DateTime {
  /// Получить разницу между указанной датой и сегодня (сейчас) в днях
  int get calculateDifferenceInDays {
    DateTime now = DateTime.now();
    return DateTime(year, month, day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  /// Получить разницу между указанной датой и сегодня в минутах
  int get calculateDifferenceInMinutes =>
      DateTime.now().difference(this).inMinutes;

  /// Является ли указанная дата текущим днем
  bool get isToday => calculateDifferenceInDays == 0;

  /// Получить только дату
  DateTime get date => DateTime(year, month, day);

  // Выходной день
  bool get isWeekend => [DateTime.sunday, DateTime.saturday].contains(weekday);
}
