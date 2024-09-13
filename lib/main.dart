import 'package:flutter/material.dart';

import './screens/welcome_screen.dart';
import './screens/create_account_screen.dart';
import './screens/validate_account_screen.dart';
import './screens/homepage_screen.dart';
import './screens/qr_code_scan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckMe pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          onPrimary: Colors.lightBlue,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.lightBlue,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (ctx) => const HomepageScreen(),
        // CreateAccountScreen.routeName: (ctx) => const CreateAccountScreen(),
        // ValidateAccountScreen.routeName: (ctx) => const ValidateAccountScreen(),
        // HomepageScreen.routeName: (ctx) => const HomepageScreen(),
        // QrCodeScanScreen.routeName: (ctx) => const QrCodeScanScreen(),
      },
    );
  }
}
