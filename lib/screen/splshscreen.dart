import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LanguageScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LanguageScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B0000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            SizedBox(height: 18),
            Text(
              "Sree Kalleri Kuttichathan Kshethram",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}