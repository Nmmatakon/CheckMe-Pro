import 'package:flutter/material.dart';

import './screens/welcome_screen.dart';
import './screens/create_account_screen.dart';
import './screens/validate_account_screen.dart';
import './screens/homepage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckMe pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          onPrimary: Colors.lightBlue,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.lightBlue,
            fontSize: 28,
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
        "/": (ctx) => const WelcomeScreen(),
        CreateAccountScreen.routeName: (ctx) => const CreateAccountScreen(),
        ValidateAccountScreen.routeName: (ctx) => const ValidateAccountScreen(),
        HomepageScreen.routeName: (ctx) => const HomepageScreen(),
      },
    );
  }
}
