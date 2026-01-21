import 'package:flutter/material.dart';

/// Custom app theme that replaces FlutterFlowTheme
/// This class centralizes all theme-related properties for your app
class AppTheme {
  // Prevent instantiation and extension
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          seedColor:
              const Color.fromARGB(255, 5, 215, 215), // Primary brand color
          brightness: Brightness.light,
        ),
        // Text theme adjustments
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
        // Button theme adjustments
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // App bar theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
        // Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2),
          ),
        ),
      );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B39EF), // Primary brand color
          brightness: Brightness.dark,
        ),
        // Text themes, button themes, etc. can be customized here similar to lightTheme
      );

  /// Helper methods to access theme colors directly (for migration from FlutterFlowTheme)
  static ColorScheme colorsOf(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  /// Primary color - equivalent to FlutterFlowTheme.of(context).primaryColor
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  /// Secondary color - equivalent to FlutterFlowTheme.of(context).secondaryColor
  static Color secondaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  /// Tertiary color - equivalent to FlutterFlowTheme.of(context).tertiaryColor
  static Color tertiaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }

  /// Primary background - equivalent to FlutterFlowTheme.of(context).primaryBackground
  static Color primaryBackground(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  /// Secondary background - equivalent to FlutterFlowTheme.of(context).secondaryBackground
  static Color secondaryBackground(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  /// Primary text - equivalent to FlutterFlowTheme.of(context).primaryText
  static Color primaryText(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// Secondary text - equivalent to FlutterFlowTheme.of(context).secondaryText
  static Color secondaryText(BuildContext context) {
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  /// Accent color - equivalent to FlutterFlowTheme.of(context).accent
  static Color accentColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceTint;
  }

  /// Error color - equivalent to FlutterFlowTheme.of(context).error
  static Color errorColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  /// Helper methods for text styles
  static TextStyle headlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!;
  }

  static TextStyle titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }
}
