import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginphone extends StatefulWidget {
  const Loginphone({super.key});

  @override
  State<Loginphone> createState() => _LoginphoneState();
}

class _LoginphoneState extends State<Loginphone> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String verificationId = '';
  bool isOtpSent = false;
  bool isLoading = false;

  void sendOtp() async {
    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
      Get.snackbar("Invalid", "Please enter a valid phone number");
      return;
    }
    setState(() => isLoading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text.trim()}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.snackbar("Success", "Phone number automatically verified!");
        // Navigate to home page here
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => isLoading = false);
        Get.snackbar("Error", e.message ?? "Verification failed");
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          isOtpSent = true;
          verificationId = verId;
          isLoading = false;
        });
        Get.snackbar("OTP Sent", "Enter the OTP sent to your phone");
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  void verifyOtp() async {
    if (otpController.text.length < 6) {
      Get.snackbar("Invalid", "Please enter a valid 6-digit OTP");
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar("Success", "Phone login successful!");
      // Navigate to home
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.white.withOpacity(0.05)),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.25),
                              border: Border.all(color: Colors.amber.shade100, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 25,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset('assets/images/workhive.png', height: 50),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "Login with Phone",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 32),

                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixText: "+91 ",
                              prefixIcon: const Icon(Icons.phone_android),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          if (isOtpSent)
                            TextField(
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              decoration: InputDecoration(
                                labelText: "Enter OTP",
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isOtpSent ? verifyOtp : sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.shade400,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 8,
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(color: Colors.black)
                                  : Text(
                                isOtpSent ? "Verify OTP" : "Send OTP",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
