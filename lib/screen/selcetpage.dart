// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../utils/GradientBackground.dart';
// import 'frrlencerllogin/frlancerloginpage.dart';
// import 'loginscreen.dart';
//
// class FreelancerOrUserPage extends StatelessWidget {
//   const FreelancerOrUserPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           "Choose Your Role",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black87),
//       ),
//       body: Stack(
//         children: [
//           // Gradient Background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // Glass Blur Overlay
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//               child: Container(color: Colors.white.withOpacity(0.05)),
//             ),
//           ),
//
//           // Content
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo Circle
//                   Container(
//                     height: 110,
//                     width: 110,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.black.withOpacity(0.2),
//                       border: Border.all(color: Colors.amber.shade100.withOpacity(0.2), width: 1.5),
//                     ),
//                     child: Center(
//                       child: Image.asset(
//                         'assets/images/workhive.png',
//                         height: 60,
//                         width: 60,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//
//                   // Title
//                   const Text(
//                     "Who Are You?",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // Freelancer Button
//                   _glassButton(
//                     label: "I'm a Freelancer",
//                     icon: Icons.work_outline,
//                     onTap: () => Get.to(() =>  FreelancerLoginPage()),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // User Button
//                   _glassButton(
//                     label: "I'm a User",
//                     icon: Icons.person_outline,
//                     onTap: () => Get.to(() => LoginPage()),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _glassButton({
//     required String label,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.4),
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(color: Colors.black.withOpacity(0.2)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 10,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: Colors.black87),
//                 const SizedBox(width: 10),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
