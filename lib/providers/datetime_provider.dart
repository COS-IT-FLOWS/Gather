import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTimeProvider with ChangeNotifier {
  final DateTime initialDate = DateTime(2024, 5, 20);
  final TimeOfDay initialTime = TimeOfDay(hour: 8, minute: 30);
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 30);

  // DateTime get initialDate => _initialDate!;
  // TimeOfDay get initialTime => _initialTime!;
  // DateTime get selectedDate => _selectedDate!;
  // TimeOfDay get selectedTime => _selectedTime!;
  // DateTime get initialDate => _initialDate;
  // TimeOfDay get initialTime => _initialTime;

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void selectTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  String getDateString(DateTime date) {
    final dateFormatter = DateFormat('MMM d');
    if (date != null) {
      return dateFormatter.format(date).toString();
    } else {
      return '';
    }
  }

  String getTimeString(BuildContext context, TimeOfDay time) {
    final timeFormatter = DateFormat('hh:mm a');
    DateTime today = DateTime.now();
    DateTime selectedTime = DateTime(
      today.year,
      today.month,
      today.day,
      time.hour,
      time.minute,
    );
    return timeFormatter.format(selectedTime).toString();
  }

  DateTime getSelectedDateTime() {
    DateTime _selectedDateTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    return _selectedDateTime;
  }
}
