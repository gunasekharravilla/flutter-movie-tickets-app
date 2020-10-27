part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get dateAndTime => "${this.shortDayName} ${this.day}, ${this.hour}:00";

  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 1:
        return 'Wed';
      case 1:
        return 'Thu';
      case 1:
        return 'Fri';
      case 1:
        return 'Sat';
      default:
        return 'Sun';
    }
  }
}
