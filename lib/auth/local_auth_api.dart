import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:sisterhood_app/utill/utils.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    final available = await _auth.getAvailableBiometrics();
    Utils.log("$available");
    try {
      return await _auth.authenticate(
          localizedReason: 'To continue, you must complete the biometrics',
          options: const AuthenticationOptions(
              useErrorDialogs: true, biometricOnly: true, stickyAuth: true),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Authentication required!',
              cancelButton: 'No thanks',
            ),
            IOSAuthMessages(
              cancelButton: 'No thanks',
            ),
          ]);
    } on PlatformException catch (e) {
      print(e.message);
      return false;
    }
  }
}
