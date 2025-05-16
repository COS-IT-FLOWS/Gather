// coverage:ignore-file
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/routes/app_routes.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
// import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gather/themes/app_theme.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  await Supabase.initialize(
    url: GlobalConfiguration().get('SUPABASE_URL'),
    anonKey: GlobalConfiguration().get('SUPABASE_ANON_KEY'),
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<SignInProvider>(
          create: (_) => SignInProvider(supabase)),
      ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(supabase, 'testUserId')),
      ChangeNotifierProvider<DateTimeProvider>(
          create: (_) => DateTimeProvider()),
      ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider())
    ], child: GatherApp()),
  );
}

final supabase = Supabase.instance.client;

class GatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gather',
        // Apply the light theme
        theme: AppTheme.lightTheme,
        // Apply the dark theme if needed
        darkTheme: AppTheme.darkTheme,
        // Let the device control the theme based on system settings
        themeMode: ThemeMode.system,
        routes: AppRoutes.routes(),
        initialRoute: Provider.of<SignInProvider>(context).isLoggedIn
            ? '/home'
            : '/authentication'
        //       scaffoldMessengerKey: globalMessengerKey,
        );
  }
}

Future<void> onSelectNotification(String payload) async {
  // Handle notification tap
  print('notifications');
}
