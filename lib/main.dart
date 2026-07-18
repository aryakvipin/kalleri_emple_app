import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalleri_emple_app/screen/splshscreen.dart';

import 'firebase_options.dart';

void main() async {
  // Required before calling any Firebase (or other plugin) APIs.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Only one top-level app widget is needed. GetMaterialApp already
    // provides everything MaterialApp does, plus GetX routing/state
    // management — wrapping it in another MaterialApp was redundant
    // and would have broken Get.to()/Get.back() navigation.
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kalleri temple',
      home: const SplashScreen(),
    );
  }
}