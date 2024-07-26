import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTimeProvider with ChangeNotifier {
  DateTime _initialDate = DateTime.now();
  TimeOfDay _initialTime = TimeOfDay(hour: 8, minute: 30);
  late DateTime _selectedDate = _initialDate;
  late TimeOfDay _selectedTime = _initialTime;

  DateTime get initialDate => _initialDate;
  TimeOfDay get initialTime => _initialTime;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  // DateTime get initialDate => _initialDate;
  // TimeOfDay get initialTime => _initialTime;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  String getDateString(date) {
    final dateFormatter = DateFormat('MMM d');
    return dateFormatter.format(date).toString();
  }

  String getTimeString(context, time) {
    final timeFormatter = DateFormat('hh:mm a');
    DateTime today = DateTime.now();
    DateTime selectedTime = DateTime(
      today.year,
      today.month,
      today.day,
      time.hour,
      time.minute,
    );
    print(selectedTime);
    return timeFormatter.format(selectedTime).toString();
  }

  DateTime getSelectedDateTime() {
    DateTime _selectedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute);
    return _selectedDateTime;
  }
}
