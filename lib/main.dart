import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme/app_theme.dart';

import './screens/welcome_screen.dart';
import './screens/create_account_screen.dart';
import './screens/validate_account_screen.dart';
import './screens/homepage_screen.dart';
import './screens/qr_code_scan_screen.dart';

import './providers/session_provider.dart';
import './providers/student_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => StudentProvider()),
        ChangeNotifierProvider(create: (ctx) => SessionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CheckMe pro',
        theme: appTheme(),
        routes: {
          "/": (ctx) => const WelcomeScreen(),
          CreateAccountScreen.routeName: (ctx) => const CreateAccountScreen(),
          ValidateAccountScreen.routeName: (ctx) =>
              const ValidateAccountScreen(),
          HomepageScreen.routeName: (ctx) => const HomepageScreen(),
          QrCodeScanScreen.routeName: (ctx) => const QrCodeScanScreen(),
        },
      ),
    );
  }
}
