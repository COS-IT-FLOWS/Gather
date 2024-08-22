// import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:gather/screens/auth_widget.dart';

// abstract class ISupabaseClient {
//   Future<void> signInWithOtp(String phone);
//   // Add other methods as needed
// }

// class SupabaseClientImpl implements ISupabaseClient {
//   final SupabaseClient _client;

//   SupabaseClientImpl(this._client);

//   @override
//   Future<void> signInWithOtp(String phone) async {
//     await _client.auth.signInWithOtp(phone: phone);
//   }
//   // ]Add other methods as
// }

// final supabaseClientProvider = Provider<ISupabaseClient>() {
//   final client = Supabase.instance.client;
//   return SupabaseClientImpl(client);
// }
