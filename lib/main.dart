import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sisterhood_app/screen/authentication/faceId_page.dart';
import 'package:sisterhood_app/screen/splash/splash_page.dart';
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
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: _default,
  ));
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SplashPage(),
      ),
    );
  }
}
