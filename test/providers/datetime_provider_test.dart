import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Ensure you import the intl package if you're using it

// Import your DateTimeProvider class
import 'package:gather/providers/datetime_provider.dart'; // Update with the correct path

void main() {
  group('DateTimeProvider', () {
    late DateTimeProvider dateTimeProvider;

    setUp(() {
      dateTimeProvider = DateTimeProvider();
    });

    test('initial values are set correctly', () {
      expect(dateTimeProvider.selectedDate, isNotNull);
      expect(dateTimeProvider.selectedTime, isNotNull);
      expect(dateTimeProvider.selectedTime.hour, 8);
      expect(dateTimeProvider.selectedTime.minute, 30);
    });

    test('selectDate updates selectedDate', () {
      DateTime newDate = DateTime(2024, 6, 15);
      dateTimeProvider.selectDate(newDate);
      expect(dateTimeProvider.selectedDate, newDate);
    });

    test('selectTime updates selectedTime', () {
      TimeOfDay newTime = TimeOfDay(hour: 10, minute: 45);
      dateTimeProvider.selectTime(newTime);
      expect(dateTimeProvider.selectedTime.hour, 10);
      expect(dateTimeProvider.selectedTime.minute, 45);
    });

    test('getDateString returns formatted date string', () {
      DateTime date = DateTime(2024, 5, 20);
      String formattedDate = dateTimeProvider.getDateString(date);
      expect(formattedDate, 'May 20');
    });

    test('getTimeString returns formatted time string', () {
      TimeOfDay time = TimeOfDay(hour: 10, minute: 45);
      String formattedTime = dateTimeProvider.getTimeString(time);
      expect(formattedTime, '10:45 AM');
    });

    test('getSelectedDateTime returns correct DateTime object', () {
      DateTime newDate = DateTime(2024, 6, 15);
      TimeOfDay newTime = TimeOfDay(hour: 10, minute: 45);
      dateTimeProvider.selectDate(newDate);
      dateTimeProvider.selectTime(newTime);
      DateTime selectedDateTime = dateTimeProvider.getSelectedDateTime();
      expect(selectedDateTime.year, 2024);
      expect(selectedDateTime.month, 6);
      expect(selectedDateTime.day, 15);
      expect(selectedDateTime.hour, 10);
      expect(selectedDateTime.minute, 45);
    });
  });
}
