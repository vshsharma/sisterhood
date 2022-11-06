import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/utils.dart';

class LocalAuthApi {
  static Future<bool> hasBiometrics() async {
    var _auth = LocalAuthentication();
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<void> stopAuthorization() async {
    var _auth = LocalAuthentication();
    var cancel = await _auth.stopAuthentication();
    print("Cancel auth: $cancel");
    return cancel;
  }

  static Future<bool> authenticate(BuildContext context) async {
    var _auth = LocalAuthentication();
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    final available = await _auth.getAvailableBiometrics();
    Utils.log("$available");
    try {
      return await _auth.authenticate(
          localizedReason: context.loc.biometric_message,
          options: const AuthenticationOptions(
              useErrorDialogs: true,
              biometricOnly: true,
              stickyAuth: false,
              sensitiveTransaction: true),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: context.loc.authentication_message,
              cancelButton: context.loc.no_thanks,
            ),
            IOSAuthMessages(
              cancelButton: context.loc.no_thanks,
            ),
          ]);
    } on PlatformException catch (e) {
      print(e.message);
      _auth.stopAuthentication();
      return false;
    }
  }
}
