import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sisterhood_app/screen/authentication/faceId_page.dart';
import 'package:sisterhood_app/screen/splash/splash_page.dart';
import 'package:sisterhood_app/theme/custom_theme.dart';
import 'package:sisterhood_app/utill/sharedprefrence.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget _default = MyApp();
  bool status = await SharedPrefManager.getBooleanPreferences() != null;

  if (status == true) {
    _default = const FaceIdPage();
  }
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    onGenerateTitle: (context) {
      return AppLocalizations.of(context).appTitle;
    },
    localizationsDelegates: const [
      AppLocalizations.delegate, // Add this line
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
    ],
    debugShowCheckedModeBanner: false,
    home: _default,
  ));
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      home: const Scaffold(
        body: SplashPage(),
      ),
    );
  }
}
