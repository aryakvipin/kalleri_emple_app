// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:workhhive/screen/userhomepage.dart';  // Adjust with your home page import
//
// class UserLoginController extends GetxController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  // void loginUser() async {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //   if (email.isEmpty || password.isEmpty) {
  //     Get.snackbar("Error", "Email and Password cannot be empty");
  //     return;
  //   }
  //
  //   try {
  //     print("Trying login for: $email");
  //
  //     UserCredential userCred = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //
  //     final uid = userCred.user!.uid;
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .get();
  //
  //     if (!userDoc.exists) {
  //       Get.snackbar("Error", "User data not found in Firestore.");
  //       await FirebaseAuth.instance.signOut();
  //       return;
  //     }
  //
  //     final userData = userDoc.data()!;
  //     if (userData['role'] != 'user') {
  //       Get.snackbar("Access Denied", "You are not a user.");
  //       await FirebaseAuth.instance.signOut();
  //       return;
  //     }
  //
  //     Get.snackbar("Login Success", "Welcome ${userData['name'] ?? 'User'}");
  //      Get.offAll(() =>
  //     // UserHomePage(udata: userData)
  //   {}
  //     );
  //
  //   } on FirebaseAuthException catch (e) {
  //     print("Firebase login error: ${e.code} - ${e.message}");
  //     Get.snackbar("Login Failed", e.message ?? "Login error");
  //   } catch (e) {
  //     print("Unexpected error: $e");
  //     Get.snackbar("Error", "Unexpected error: $e");
  //   }
  // }

//}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/admin/dashboard_screen.dart';
import '../../screen/user_home_page.dart';

class UserLoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  // Default admin account. Change this password once you're live —
  // it's only here as a fallback so the admin can log in even before
  // a matching document exists in the `admin` collection.
  static const String _defaultAdminEmail = 'kalleritempeadmin@gmail.com';

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    isLoading.value = true;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = credential.user!.uid;

      // 1. Check admin collection by UID doc-ID first (fast, direct lookup).
      final adminDocById =
      await FirebaseFirestore.instance.collection('admin').doc(uid).get();

      if (adminDocById.exists) {
        Get.offAll(() => const DashboardScreen());
        return;
      }

      // 1a. Fallback: admin doc might exist but keyed by a different
      // doc-ID (e.g. created manually in console). Check by email field too.
      final adminQuery = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (adminQuery.docs.isNotEmpty) {
        Get.offAll(() => const DashboardScreen());
        return;
      }

      // 1b. Fallback: known default admin email, even if no Firestore
      // doc has been created for them yet.
      if (email.toLowerCase() == _defaultAdminEmail) {
        // Auto-create the admin doc so future logins hit the normal path.
        await FirebaseFirestore.instance.collection('admin').doc(uid).set({
          'fullName': 'Admin',
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.offAll(() => const DashboardScreen());
        return;
      }

      // 2. Otherwise check the users collection and grab their name.
      final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        final username = (data?['fullName'] as String?) ?? 'Devotee';

        Get.offAll(() => UserHomePage(username: username));
        return;
      }

      // Signed in with Auth but no matching Firestore profile at all.
      Get.snackbar(
        'Login failed',
        'No profile found for this account. Please contact support.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'user-not-found' => 'No account found for that email.',
        'wrong-password' => 'Incorrect password.',
        'invalid-email' => 'That email address looks invalid.',
        'invalid-credential' => 'Incorrect email or password.',
        'user-disabled' => 'This account has been disabled.',
        _ => e.message ?? 'Something went wrong. Please try again.',
      };

      Get.snackbar(
        'Login failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );
    } catch (e) {
      // Print the real error so Firestore permission/rules issues are
      // visible instead of hidden behind a generic message.
      debugPrint('Login error: $e');

      Get.snackbar(
        'Login failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );
    } finally {
      isLoading.value = false;
    }
  }
}