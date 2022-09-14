
import 'package:dharims_web/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// flutter build apk --split-per-abi
void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp(
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyAS_102cZxKVNUP5V9ZiwbhJ9gd2ywn4Mg",
  //         appId: "1:693154006367:web:519a48f02284504ce322ea",
  //         messagingSenderId: "693154006367",
  //         storageBucket: "dharims-886b0.appspot.com",
  //         projectId: "dharims-886b0"));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: SplashScreen(),
    );
  }
}
