// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart'; // For Android

class FingerprintAuth {
  final LocalAuthentication auth = LocalAuthentication();

// Check is Finger print is supported on this device
  Future<bool> checkFingerPrint() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometrics = false;
    }
    return canCheckBiometrics;
  }

// Requesting fingerprint authentication
  Future<bool> showFingerPrint() async {
    bool didAuthenticate = false;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.strong)) {
      try {
        didAuthenticate = await auth.authenticate(
          localizedReason:
              'Veuillez vous authentifier pour répondre à l\'appel',
          options: const AuthenticationOptions(
            sensitiveTransaction: true,
            biometricOnly: true,
          ),
        );
      } on PlatformException catch (e) {
        print(e);
        // Handle authentication error
      }
    }
    return didAuthenticate;
  }
}
