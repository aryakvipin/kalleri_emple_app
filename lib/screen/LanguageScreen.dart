import 'package:flutter/material.dart';

import 'loginscreen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final h = constraints.maxHeight;
          final w = constraints.maxWidth;

          return Container(
            width: double.infinity,
            height: double.infinity,

            // FIGMA STYLE BACKGROUND
            decoration: const BoxDecoration(
              color: Color(0xFF7B1010),
            ),

            child: SafeArea(
              child: Stack(
                children: [

                  // BACK BUTTON
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  // TEMPLE TITLE
                  Positioned(
                    top: h * 0.035,
                    left: 25,
                    right: 25,
                    child: const Column(
                      children: [
                        Text(
                          "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black38,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Sree Kalleri Kuttichathan Kshethram",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // GOD IMAGE
                  Positioned(
                    top: h * 0.20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        "assets/images/god1.png",
                        height: h * 0.30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // LEFT LAMP
                  Positioned(
                    top: h * 0.40,
                    left: 10,
                    child: Image.asset(
                      "assets/images/lambb.png",
                      width: w * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // RIGHT LAMP
                  Positioned(
                    top: h * 0.40,
                    right: 10,
                    child: Image.asset(
                      "assets/images/lambb.png",
                      width: w * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // LANGUAGE SECTION
                  Positioned(
                    left: 25,
                    right: 25,
                    bottom: 25,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const Text(
                          "Select language for the app",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        languageTile("English"),

                        const SizedBox(height: 12),

                        languageTile("Malayalam"),

                        const SizedBox(height: 22),

                        // CONTINUE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to Login Screen
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(

                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  LoginPage(),
                                      ));
                                }, child: const Text("CONTINUE",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,),
                                ) ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget languageTile(String title) {
    final bool isSelected = language == title;

    return InkWell(
      onTap: () {
        setState(() {
          language = title;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.language,
              color: Colors.white,
              size: 24,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Radio<String>(
              value: title,
              groupValue: language,
              activeColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => Colors.white,
              ),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    language = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}