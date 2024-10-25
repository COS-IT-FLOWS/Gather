import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gather/providers/profile_provider.dart'; // Adjust the import based on your file structure

void main() {
  test('ProfileProvider initial state', () {
    final profileProvider = ProfileProvider();

    // Verify initial state
    expect(profileProvider.isEditProfileDetails, isFalse);
    expect(profileProvider.stationIds, []);
  });

  test('ProfileProvider setProfileEditFlag updates state', () {
    final profileProvider = ProfileProvider();

    // Change the edit profile flag
    profileProvider.setProfileEditFlag(true);

    // Verify the updated state
    expect(profileProvider.isEditProfileDetails, isTrue);
  });

  test('ProfileProvider setStationIds updates state', () {
    final profileProvider = ProfileProvider();

    // Set station IDs
    final testStationIds = ['station1', 'station2'];
    profileProvider.setStationIds(testStationIds);

    // Verify the updated state
    expect(profileProvider.stationIds, testStationIds);
  });

  test('ProfileProvider notifies listeners on state change', () {
    final profileProvider = ProfileProvider();
    bool listenerCalled = false;

    // Add a listener to the provider
    profileProvider.addListener(() {
      listenerCalled = true;
    });

    // Change the edit profile flag
    profileProvider.setProfileEditFlag(true);

    // Verify that the listener was called
    expect(listenerCalled, isTrue);
  });
}
