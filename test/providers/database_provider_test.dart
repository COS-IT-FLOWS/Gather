
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:global_configuration/global_configuration.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:gather/models/user_data_model.dart';
// import 'package:gather/models/hazard_data_model.dart';

// // Import your DatabaseProvider class
// import 'package:gather/providers/database_provider.dart'; // Update with the correct path

// // Create a mock class for SupabaseClient
// // class MockSupabaseClient extends Mock implements SupabaseClient {}
// @GenerateMocks([supabase.Client])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   // late MockSupabaseClient mockSupabaseClient;
//   late DatabaseProvider databaseProvider;
//   final GlobalConfiguration config = GlobalConfiguration();

//   setUp(() async {
//     final mockSupabaseClient = MockClient();
//     config.loadFromAsset('app_settings');
//     databaseProvider = DatabaseProvider(mockSupabaseClient, 'testUserId');
//   });

//   group('DatabaseProvider', () {
//     test('insertWeatherData calls insert with correct parameters', () async {
//       const parameter = 'RAINFALL';
//       final timeStamp = DateTime(2024, 10, 26);
//       const stationId = 'STN0001';
//       const parameterValue = 25.0;
//       String dataTable = 'precipitation_metdata';
//       // Mock the insert method

//       // when(mockSupabaseClient.from(dataTable).insert(anything))
//       //     .thenReturn((_) async {
//       //   return mockSupabaseClient.from(dataTable); // Return self for chaining
//       // });

//       // Mock the select method

//       when(mockSupabaseClient.from(dataTable).insert(anything).select())
//           .thenAnswer((_) async {
//         return [
//           {'status': 'success'}
//         ]; // Mock response
//       } as Answering<PostgrestTransformBuilder<PostgrestList>>);

//       final result = await databaseProvider.insertWeatherData(
//           parameter, timeStamp, stationId, parameterValue);

//       expect(result, true);
//       // verify(mockSupabaseClient.from('table')).called(1);
//       // verify(mockSupabaseClient.insert(any)).called(1);
//     });

//     test('readUser Data returns UserDataModel when user data is found',
//         () async {
//       final mockUserData = [
//         {
//           'first_name': 'John',
//           'last_name': 'Doe',
//           'phone_number': '1234567890',
//           'email': 'johndoe@example.com',
//           'occupation': 'Developer',
//           'age': 30,
//           'station_id': ['station-1', 'station-2'],
//         }
//       ];

//       when(mockSupabaseClient.from('profiles'))
//           .thenReturn(mockSupabaseClient as SupabaseQueryBuilder);
//       when(mockSupabaseClient.select('*')).thenReturn(mockSupabaseClient);
//       when(mockSupabaseClient.eq('id', 'user-id'))
//           .thenAnswer((_) async => mockUserData);

//       final userData = await databaseProvider.readUserData('user-id');

//       expect(userData.firstName, 'John');
//       expect(userData.lastName, 'Doe');
//       expect(userData.phoneNumber, '1234567890');
//       expect(userData.emailAddress, 'johndoe@example.com');
//       expect(userData.occupation, 'Developer');
//       expect(userData.userAge, 30);
//       expect(userData.stationIds, ['station-1', 'station-2']);
//     });

//     test('readUser Data returns empty UserDataModel when no user data is found',
//         () async {
//       when(mockSupabaseClient.from('profiles')).thenReturn(mockSupabaseClient);
//       when(mockSupabaseClient.select('*')).thenReturn(mockSupabaseClient);
//       when(mockSupabaseClient.eq('id', 'user-id')).thenAnswer((_) async => []);

//       final userData = await databaseProvider.readUserData('user-id');

//       expect(userData.firstName, '');
//       expect(userData.lastName, '');
//       expect(userData.phoneNumber, '');
//       expect(userData.emailAddress, '');
//       expect(userData.occupation, '');
//       expect(userData.userAge, 0);
//       expect(userData.stationIds, []);
//     });

//     test('insertUser Data calls upsert with correct parameters', () async {
//       final userDataWriteModel = UserDataModel(
//         firstName: 'Jane',
//         lastName: 'Doe',
//         phoneNumber: '0987654321',
//         emailAddress: 'janedoe@example.com',
//         occupation: 'Designer',
//         userAge: 28,
//         stationIds: [],
//       );

//       when(mockSupabaseClient.from('profiles')).thenReturn(mockSupabaseClient);
//       when(mockSupabaseClient.upsert(any))
//           .thenAnswer((_) async => Future.value());

//       final result = await databaseProvider.insertUserData(userDataWriteModel);

//       expect(result, true);
//       verify(mockSupabaseClient.from('profiles')).called(1);
//       verify(mockSupabaseClient.upsert(any)).called(1);
//     });

//     test(
//         'insertHazardEventDataAndGetHazardId calls upsert with correct parameters',
//         () async {
//       final hazardDataWriteModel = HazardDataModel(
//         hazardType: 'Fire',
//         hazardDescription: 'A fire broke out in the building',
//       );

//       when(mockSupabaseClient.from('hazard_events'))
//           .thenReturn(mockSupabaseClient);
//       when(mockSupabaseClient.upsert(any))
//           .thenAnswer((_) async => {'id': 'hazard-id'});

//       final hazardId = await databaseProvider
//           .insertHazardEventDataAndGetHazardId(hazardDataWriteModel);

//       expect(hazardId, 'hazard-id');
//       verify(mockSupabaseClient.from('hazard_events')).called(1);
//       verify(mockSupabaseClient.upsert(any)).called(1);
//     });

//     test('uploadFiles calls upload with correct parameters', () async {
//       final hazardId = 'hazard-id';
//       final pickedImages = [
//         File('path/to/image1.jpg'),
//         File('path/to/image2.jpg')
//       ];
//       final savedFilePath = 'path/to/saved/image.jpg';

//       when(mockSupabaseClient.storage.from('hazard_event_media'))
//           .thenReturn(mockSupabaseClient.storage);
//       when(mockSupabaseClient.storage.upload(any, any))
//           .thenAnswer((_) async => Future.value());

//       final result = await databaseProvider.uploadFiles(
//           hazardId, pickedImages, savedFilePath);

//       expect(result, true);
//       verify(mockSupabaseClient.storage.from('hazard_event_media')).called(3);
//       verify(mockSupabaseClient.storage.upload(any, any)).called(3);
//     });
//   });
// }
