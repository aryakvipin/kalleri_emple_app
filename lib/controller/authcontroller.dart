// // // controllers/auth_controller.dart
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:get/get.dart';
// // import 'package:workhhive/screen/selcetpage.dart' show FreelancerOrUserPage;
// // import '../screen/frrlencerllogin/freelancer home.dart';
// // import '../screen/userhomepage.dart';
// //
// // class AuthController extends GetxController {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   Future<void> checkUserLoggedIn() async {
// //     User? currentUser = _auth.currentUser;
// //
// //     if (currentUser == null) {
// //       // No user logged in—go to selection screen
// //       Get.offAll(() => FreelancerOrUserPage());
// //       return;
// //     }
// //
// //     // First, check in the 'users' collection
// //     DocumentSnapshot userDoc = await _firestore
// //         .collection('users')
// //         .doc(currentUser.uid)
// //         .get();
// //
// //     if (userDoc.exists) {
// //       final data = userDoc.data() as Map<String, dynamic>;
// //       final role = data.containsKey('role') ? data['role'] : null;
// //
// //       if (role == 'user') {
// //         // Navigate to user home
// //         Get.offAll(() => UserHomePage(udata: data));
// //         return;
// //       }
// //     }
// //
// //     // Next, check in the 'freelancers' collection
// //     DocumentSnapshot freelancerDoc = await _firestore
// //         .collection('freelancers')
// //         .doc(currentUser.uid)
// //         .get();
// //
// //     if (freelancerDoc.exists) {
// //       final fData = freelancerDoc.data() as Map<String, dynamic>;
// //       final role = fData.containsKey('role') ? fData['role'] : null;
// //
// //       if (role == 'freelancer') {
// //         // Navigate to freelancer home
// //         Get.offAll(() => FreelancerHomePage(data: fData));
// //         return;
// //       }
// //     }
// //
// //     // Fallback if no valid role found
// //     Get.snackbar("Error", "User role not found or invalid.",
// //         snackPosition: SnackPosition.BOTTOM);
// //     Get.offAll(() => FreelancerOrUserPage());
// //   }
// //
// //   Future<void> logout() async {
// //     await _auth.signOut();
// //     Get.offAll(() => FreelancerOrUserPage());
// //   }
// // }
// // controllers/auth_controller.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:workhhive/screen/selcetpage.dart';
// import '../screen/frrlencerllogin/freelancer home.dart';
// import '../screen/userhomepage.dart';
//
// class AuthController extends GetxController with WidgetsBindingObserver {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String? currentUserId;
//   String? userType; // 'users' or 'freelancers'
//
//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _updateStatus(false);
//     super.onClose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (currentUserId == null || userType == null) return;
//
//     if (state == AppLifecycleState.resumed) {
//       _updateStatus(true);
//     } else {
//       _updateStatus(false);
//     }
//   }
//
//   Future<void> checkUserLoggedIn() async {
//     User? currentUser = _auth.currentUser;
//
//     if (currentUser == null) {
//       Get.offAll(() => FreelancerOrUserPage());
//       return;
//     }
//
//     currentUserId = currentUser.uid;
//
//     // Check users collection
//     DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUserId).get();
//     if (userDoc.exists) {
//       userType = 'users';
//       final data = userDoc.data() as Map<String, dynamic>;
//       final role = data['role'];
//       if (role == 'user') {
//         _updateStatus(true);
//         Get.offAll(() => UserHomePage(udata: data));
//         return;
//       }
//     }
//
//     // Check freelancers collection
//     DocumentSnapshot freelancerDoc = await _firestore.collection('freelancers').doc(currentUserId).get();
//     if (freelancerDoc.exists) {
//       userType = 'freelancers';
//       final data = freelancerDoc.data() as Map<String, dynamic>;
//       final role = data['role'];
//       if (role == 'freelancer') {
//         _updateStatus(true);
//         Get.offAll(() => FreelancerHomePage(data: data));
//         return;
//       }
//     }
//
//     // Fallback
//     Get.snackbar("Error", "User role not found or invalid.", snackPosition: SnackPosition.BOTTOM);
//     Get.offAll(() => FreelancerOrUserPage());
//   }
//
//   Future<void> _updateStatus(bool isOnline) async {
//     if (currentUserId == null || userType == null) return;
//
//     await _firestore.collection(userType!).doc(currentUserId!).update({
//       'isOnline': isOnline,
//       'lastSeen': FieldValue.serverTimestamp(),
//     });
//   }
//
//   Future<void> logout() async {
//     _updateStatus(false); // Set offline before logout
//     await _auth.signOut();
//     Get.offAll(() => FreelancerOrUserPage());
//   }
// }
