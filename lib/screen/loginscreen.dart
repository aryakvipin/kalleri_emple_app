// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:kalleri_emple_app/screen/signup.dart';
// // import 'package:kalleri_emple_app/screen/user_home_page.dart';
// //
// // import '../controller/usercontoller/user_login_controller.dart';
// //
// // class LoginPage extends StatelessWidget {
// //   LoginPage({super.key});
// //
// //   final UserLoginController controller = Get.put(UserLoginController());
// //
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: true,
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [
// //               Color(0xFF9E1711),
// //               Color(0xFF7B100C),
// //               Color(0xFF5B0000),
// //               Color(0xFF8E120D),
// //             ],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: LayoutBuilder(
// //             builder: (context, constraints) {
// //               return SingleChildScrollView(
// //                 keyboardDismissBehavior:
// //                 ScrollViewKeyboardDismissBehavior.onDrag,
// //                 padding: const EdgeInsets.symmetric(horizontal: 24),
// //                 child: ConstrainedBox(
// //                   constraints: BoxConstraints(
// //                     minHeight: constraints.maxHeight,
// //                   ),
// //                   child: Form(
// //                     key: formKey,
// //                     child: Column(
// //                       children: [
// //                         // BACK BUTTON
// //                         Align(
// //                           alignment: Alignment.centerLeft,
// //                           child: IconButton(
// //                             padding: EdgeInsets.zero,
// //                             onPressed: () {
// //                               Get.back();
// //                             },
// //                             icon: const Icon(
// //                               Icons.arrow_back_ios_new,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ),
// //
// //                         const SizedBox(height: 2),
// //
// //                         // MALAYALAM TITLE
// //                         const Text(
// //                           "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 24,
// //                             height: 1.2,
// //                             fontWeight: FontWeight.bold,
// //                             shadows: [
// //                               Shadow(
// //                                 blurRadius: 4,
// //                                 color: Colors.black38,
// //                                 offset: Offset(1, 2),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //
// //                         const SizedBox(height: 4),
// //
// //                         // ENGLISH TITLE
// //                         const Text(
// //                           "Sree Kalleri Kuttichathan Kshethram",
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 13,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //
// //                         const SizedBox(height: 8),
// //
// //                         // GOD IMAGE + LAMPS
// //                         SizedBox(
// //                           height: 175,
// //                           width: double.infinity,
// //                           child: Stack(
// //                             alignment: Alignment.center,
// //                             children: [
// //                               Image.asset(
// //                                 "assets/images/god1.png",
// //                                 height: 170,
// //                                 fit: BoxFit.contain,
// //                               ),
// //
// //                               Positioned(
// //                                 left: 5,
// //                                 bottom: 10,
// //                                 child: Image.asset(
// //                                   "assets/images/lambb.png",
// //                                   width: 42,
// //                                 ),
// //                               ),
// //
// //                               Positioned(
// //                                 right: 5,
// //                                 bottom: 10,
// //                                 child: Image.asset(
// //                                   "assets/images/lambb.png",
// //                                   width: 42,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //
// //                         const SizedBox(height: 8),
// //
// //                         Align(
// //                           alignment: Alignment.centerLeft,
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               const Text(
// //                                 "Sign in",
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 27,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //
// //                               const SizedBox(height: 2),
// //
// //                               const Text(
// //                                 "Continue your sacred journey",
// //                                 style: TextStyle(
// //                                   color: Colors.white70,
// //                                   fontSize: 14,
// //                                   fontWeight: FontWeight.w500,
// //                                 ),
// //                               ),
// //
// //                               const SizedBox(height: 16),
// //
// //                               // EMAIL FIELD
// //                               _inputField(
// //                                 controller: controller.emailController,
// //                                 label: "EMAIL",
// //                                 hint: "Enter your email",
// //                                 icon: Icons.email_outlined,
// //                                 keyboardType: TextInputType.emailAddress,
// //                                 validator: (value) {
// //                                   if (value == null ||
// //                                       value.trim().isEmpty) {
// //                                     return "Please enter your email";
// //                                   }
// //
// //                                   if (!GetUtils.isEmail(value.trim())) {
// //                                     return "Please enter a valid email";
// //                                   }
// //
// //                                   return null;
// //                                 },
// //                               ),
// //
// //                               const SizedBox(height: 12),
// //
// //                               // PASSWORD FIELD
// //                               _inputField(
// //                                 controller: controller.passwordController,
// //                                 label: "PASSWORD",
// //                                 hint: "Enter your password",
// //                                 icon: Icons.lock_outline,
// //                                 obscure: true,
// //                                 validator: (value) {
// //                                   if (value == null || value.isEmpty) {
// //                                     return "Please enter your password";
// //                                   }
// //
// //                                   if (value.length < 6) {
// //                                     return "Password must be at least 6 characters";
// //                                   }
// //
// //                                   return null;
// //                                 },
// //                               ),
// //
// //                               const SizedBox(height: 18),
// //
// //                               // LOGIN BUTTON
// //                               SizedBox(
// //                                 width: double.infinity,
// //                                 height: 50,
// //                                 child: OutlinedButton(
// //                                   onPressed: () {
// //                                     FocusScope.of(context).unfocus();
// //
// //                                     if (formKey.currentState!.validate()) {
// //                                       Get.offAll(() => UserHomePage());
// //                                     }
// //                                   },
// //                                   style: OutlinedButton.styleFrom(
// //                                     foregroundColor: Colors.white,
// //                                     side: const BorderSide(
// //                                       color: Colors.white,
// //                                       width: 2,
// //                                     ),
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius:
// //                                       BorderRadius.circular(10),
// //                                     ),
// //                                   ),
// //                                   child: const Row(
// //                                     mainAxisAlignment:
// //                                     MainAxisAlignment.center,
// //                                     children: [
// //                                       Text(
// //                                         "LOGIN",
// //                                         style: TextStyle(
// //                                           fontSize: 17,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                       SizedBox(width: 10),
// //                                       Icon(Icons.arrow_forward),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //
// //                               const SizedBox(height: 15),
// //
// //                               // CREATE NEW ACCOUNT
// //                               Center(
// //                                 child: Wrap(
// //                                   alignment: WrapAlignment.center,
// //                                   crossAxisAlignment:
// //                                   WrapCrossAlignment.center,
// //                                   children: [
// //                                     const Text(
// //                                       "Don't have an account?",
// //                                       style: TextStyle(
// //                                         color: Colors.white70,
// //                                         fontSize: 14,
// //                                       ),
// //                                     ),
// //                                     TextButton(
// //                                       onPressed: () {
// //                                         Get.to(() => const SignUpPage());
// //                                       },
// //                                       child: const Text(
// //                                         "Create New Account",
// //                                         style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontSize: 14,
// //                                           fontWeight: FontWeight.bold,
// //                                           decoration:
// //                                           TextDecoration.underline,
// //                                           decorationColor: Colors.white,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //
// //                               const SizedBox(height: 10),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _inputField({
// //     required TextEditingController controller,
// //     required String label,
// //     required String hint,
// //     required IconData icon,
// //     required String? Function(String?) validator,
// //     TextInputType keyboardType = TextInputType.text,
// //     bool obscure = false,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(
// //             color: Colors.white,
// //             fontSize: 13,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //
// //         const SizedBox(height: 5),
// //
// //         TextFormField(
// //           controller: controller,
// //           obscureText: obscure,
// //           keyboardType: keyboardType,
// //           cursorColor: Colors.white,
// //           style: const TextStyle(
// //             color: Colors.white,
// //             fontSize: 15,
// //           ),
// //           validator: validator,
// //           autovalidateMode: AutovalidateMode.onUserInteraction,
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: const TextStyle(
// //               color: Colors.white60,
// //             ),
// //             prefixIcon: Icon(
// //               icon,
// //               color: Colors.white,
// //             ),
// //             errorStyle: const TextStyle(
// //               color: Color(0xFFFFD6D6),
// //               fontSize: 12,
// //               fontWeight: FontWeight.w500,
// //             ),
// //             contentPadding: const EdgeInsets.symmetric(
// //               horizontal: 15,
// //               vertical: 13,
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               borderSide: const BorderSide(
// //                 color: Colors.white,
// //                 width: 2,
// //               ),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               borderSide: const BorderSide(
// //                 color: Colors.white,
// //                 width: 2.5,
// //               ),
// //             ),
// //             errorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               borderSide: const BorderSide(
// //                 color: Color(0xFFFFD6D6),
// //                 width: 2,
// //               ),
// //             ),
// //             focusedErrorBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               borderSide: const BorderSide(
// //                 color: Color(0xFFFFD6D6),
// //                 width: 2.5,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kalleri_emple_app/screen/signup.dart';
// import 'package:kalleri_emple_app/screen/user_home_page.dart';
//
// import '../controller/usercontoller/user_login_controller.dart';
//
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//
//   final UserLoginController controller = Get.put(UserLoginController());
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF9E1711),
//               Color(0xFF7B100C),
//               Color(0xFF5B0000),
//               Color(0xFF8E120D),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return SingleChildScrollView(
//                 keyboardDismissBehavior:
//                 ScrollViewKeyboardDismissBehavior.onDrag,
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: constraints.maxHeight,
//                   ),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         // BACK BUTTON
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: IconButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                               Get.back();
//                             },
//                             icon: const Icon(
//                               Icons.arrow_back_ios_new,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 2),
//
//                         // MALAYALAM TITLE
//                         const Text(
//                           "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             height: 1.2,
//                             fontWeight: FontWeight.bold,
//                             shadows: [
//                               Shadow(
//                                 blurRadius: 4,
//                                 color: Colors.black38,
//                                 offset: Offset(1, 2),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 4),
//
//                         // ENGLISH TITLE
//                         const Text(
//                           "Sree Kalleri Kuttichathan Kshethram",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // GOD IMAGE + LAMPS
//                         SizedBox(
//                           height: 175,
//                           width: double.infinity,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Image.asset(
//                                 "assets/images/god1.png",
//                                 height: 170,
//                                 fit: BoxFit.contain,
//                               ),
//
//                               Positioned(
//                                 left: 5,
//                                 bottom: 10,
//                                 child: Image.asset(
//                                   "assets/images/lambb.png",
//                                   width: 42,
//                                 ),
//                               ),
//
//                               Positioned(
//                                 right: 5,
//                                 bottom: 10,
//                                 child: Image.asset(
//                                   "assets/images/lambb.png",
//                                   width: 42,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 27,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 2),
//
//                               const Text(
//                                 "Continue your sacred journey",
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 16),
//
//                               // EMAIL FIELD
//                               _inputField(
//                                 controller: controller.emailController,
//                                 label: "EMAIL",
//                                 hint: "Enter your email",
//                                 icon: Icons.email_outlined,
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value == null ||
//                                       value.trim().isEmpty) {
//                                     return "Please enter your email";
//                                   }
//
//                                   if (!GetUtils.isEmail(value.trim())) {
//                                     return "Please enter a valid email";
//                                   }
//
//                                   return null;
//                                 },
//                               ),
//
//                               const SizedBox(height: 12),
//
//                               // PASSWORD FIELD
//                               _inputField(
//                                 controller: controller.passwordController,
//                                 label: "PASSWORD",
//                                 hint: "Enter your password",
//                                 icon: Icons.lock_outline,
//                                 obscure: true,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your password";
//                                   }
//
//                                   if (value.length < 6) {
//                                     return "Password must be at least 6 characters";
//                                   }
//
//                                   return null;
//                                 },
//                               ),
//
//                               const SizedBox(height: 18),
//
//                               // LOGIN BUTTON
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 50,
//                                 child: Obx(
//                                       () => OutlinedButton(
//                                     onPressed: controller.isLoading.value
//                                         ? null
//                                         : () {
//                                       FocusScope.of(context).unfocus();
//
//                                       if (formKey.currentState!
//                                           .validate()) {
//                                         controller.login();
//                                       }
//                                     },
//                                     style: OutlinedButton.styleFrom(
//                                       foregroundColor: Colors.white,
//                                       side: const BorderSide(
//                                         color: Colors.white,
//                                         width: 2,
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                         BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: controller.isLoading.value
//                                         ? const SizedBox(
//                                       width: 22,
//                                       height: 22,
//                                       child: CircularProgressIndicator(
//                                         color: Colors.white,
//                                         strokeWidth: 2.4,
//                                       ),
//                                     )
//                                         : const Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "LOGIN",
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight:
//                                             FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(width: 10),
//                                         Icon(Icons.arrow_forward),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               // CREATE NEW ACCOUNT
//                               Center(
//                                 child: Wrap(
//                                   alignment: WrapAlignment.center,
//                                   crossAxisAlignment:
//                                   WrapCrossAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Don't have an account?",
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         Get.to(() => const SignUpPage());
//                                       },
//                                       child: const Text(
//                                         "Create New Account",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           decoration:
//                                           TextDecoration.underline,
//                                           decorationColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _inputField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscure = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//
//         const SizedBox(height: 5),
//
//         TextFormField(
//           controller: controller,
//           obscureText: obscure,
//           keyboardType: keyboardType,
//           cursorColor: Colors.white,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//           ),
//           validator: validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(
//               color: Colors.white60,
//             ),
//             prefixIcon: Icon(
//               icon,
//               color: Colors.white,
//             ),
//             errorStyle: const TextStyle(
//               color: Color(0xFFFFD6D6),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 13,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Colors.white,
//                 width: 2,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Colors.white,
//                 width: 2.5,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Color(0xFFFFD6D6),
//                 width: 2,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Color(0xFFFFD6D6),
//                 width: 2.5,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kalleri_emple_app/screen/signup.dart';
// import 'package:kalleri_emple_app/screen/user_home_page.dart';
//
// import '../controller/usercontoller/user_login_controller.dart';
//
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//
//   final UserLoginController controller = Get.put(UserLoginController());
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF9E1711),
//               Color(0xFF7B100C),
//               Color(0xFF5B0000),
//               Color(0xFF8E120D),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return SingleChildScrollView(
//                 keyboardDismissBehavior:
//                 ScrollViewKeyboardDismissBehavior.onDrag,
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: constraints.maxHeight,
//                   ),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         // BACK BUTTON
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: IconButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                               Get.back();
//                             },
//                             icon: const Icon(
//                               Icons.arrow_back_ios_new,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 2),
//
//                         // MALAYALAM TITLE
//                         const Text(
//                           "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             height: 1.2,
//                             fontWeight: FontWeight.bold,
//                             shadows: [
//                               Shadow(
//                                 blurRadius: 4,
//                                 color: Colors.black38,
//                                 offset: Offset(1, 2),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 4),
//
//                         // ENGLISH TITLE
//                         const Text(
//                           "Sree Kalleri Kuttichathan Kshethram",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // GOD IMAGE + LAMPS
//                         SizedBox(
//                           height: 175,
//                           width: double.infinity,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Image.asset(
//                                 "assets/images/god1.png",
//                                 height: 170,
//                                 fit: BoxFit.contain,
//                               ),
//
//                               Positioned(
//                                 left: 5,
//                                 bottom: 10,
//                                 child: Image.asset(
//                                   "assets/images/lambb.png",
//                                   width: 42,
//                                 ),
//                               ),
//
//                               Positioned(
//                                 right: 5,
//                                 bottom: 10,
//                                 child: Image.asset(
//                                   "assets/images/lambb.png",
//                                   width: 42,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 27,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 2),
//
//                               const Text(
//                                 "Continue your sacred journey",
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 16),
//
//                               // EMAIL FIELD
//                               _inputField(
//                                 controller: controller.emailController,
//                                 label: "EMAIL",
//                                 hint: "Enter your email",
//                                 icon: Icons.email_outlined,
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value == null ||
//                                       value.trim().isEmpty) {
//                                     return "Please enter your email";
//                                   }
//
//                                   if (!GetUtils.isEmail(value.trim())) {
//                                     return "Please enter a valid email";
//                                   }
//
//                                   return null;
//                                 },
//                               ),
//
//                               const SizedBox(height: 12),
//
//                               // PASSWORD FIELD
//                               _inputField(
//                                 controller: controller.passwordController,
//                                 label: "PASSWORD",
//                                 hint: "Enter your password",
//                                 icon: Icons.lock_outline,
//                                 obscure: true,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your password";
//                                   }
//
//                                   if (value.length < 6) {
//                                     return "Password must be at least 6 characters";
//                                   }
//
//                                   return null;
//                                 },
//                               ),
//
//                               const SizedBox(height: 18),
//
//                               // LOGIN BUTTON
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 50,
//                                 child: OutlinedButton(
//                                   onPressed: () {
//                                     FocusScope.of(context).unfocus();
//
//                                     if (formKey.currentState!.validate()) {
//                                       Get.offAll(() => UserHomePage());
//                                     }
//                                   },
//                                   style: OutlinedButton.styleFrom(
//                                     foregroundColor: Colors.white,
//                                     side: const BorderSide(
//                                       color: Colors.white,
//                                       width: 2,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "LOGIN",
//                                         style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Icon(Icons.arrow_forward),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               // CREATE NEW ACCOUNT
//                               Center(
//                                 child: Wrap(
//                                   alignment: WrapAlignment.center,
//                                   crossAxisAlignment:
//                                   WrapCrossAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Don't have an account?",
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         Get.to(() => const SignUpPage());
//                                       },
//                                       child: const Text(
//                                         "Create New Account",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           decoration:
//                                           TextDecoration.underline,
//                                           decorationColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _inputField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscure = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//
//         const SizedBox(height: 5),
//
//         TextFormField(
//           controller: controller,
//           obscureText: obscure,
//           keyboardType: keyboardType,
//           cursorColor: Colors.white,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//           ),
//           validator: validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(
//               color: Colors.white60,
//             ),
//             prefixIcon: Icon(
//               icon,
//               color: Colors.white,
//             ),
//             errorStyle: const TextStyle(
//               color: Color(0xFFFFD6D6),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 13,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Colors.white,
//                 width: 2,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Colors.white,
//                 width: 2.5,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Color(0xFFFFD6D6),
//                 width: 2,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(
//                 color: Color(0xFFFFD6D6),
//                 width: 2.5,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalleri_emple_app/screen/signup.dart';
import 'package:kalleri_emple_app/screen/user_home_page.dart';

import '../controller/usercontoller/user_login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final UserLoginController controller = Get.put(UserLoginController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Runs the login flow and, only if it actually succeeded (i.e.
  /// FirebaseAuth now has a signed-in user), clears the email/password
  /// fields. A failed attempt — wrong password, etc. — leaves the form
  /// as-is so the person isn't forced to retype everything just to see
  /// the error message.
  Future<void> _handleLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;

    await controller.login();

    if (FirebaseAuth.instance.currentUser != null) {
      controller.emailController.clear();
      controller.passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9E1711),
              Color(0xFF7B100C),
              Color(0xFF5B0000),
              Color(0xFF8E120D),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // BACK BUTTON
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 2),

                        // MALAYALAM TITLE
                        const Text(
                          "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.2,
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

                        const SizedBox(height: 4),

                        // ENGLISH TITLE
                        const Text(
                          "Sree Kalleri Kuttichathan Kshethram",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // GOD IMAGE + LAMPS
                        SizedBox(
                          height: 175,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/god1.png",
                                height: 170,
                                fit: BoxFit.contain,
                              ),

                              Positioned(
                                left: 5,
                                bottom: 10,
                                child: Image.asset(
                                  "assets/images/lambb.png",
                                  width: 42,
                                ),
                              ),

                              Positioned(
                                right: 5,
                                bottom: 10,
                                child: Image.asset(
                                  "assets/images/lambb.png",
                                  width: 42,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 2),

                              const Text(
                                "Continue your sacred journey",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // EMAIL FIELD
                              _inputField(
                                controller: controller.emailController,
                                label: "EMAIL",
                                hint: "Enter your email",
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return "Please enter your email";
                                  }

                                  if (!GetUtils.isEmail(value.trim())) {
                                    return "Please enter a valid email";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 12),

                              // PASSWORD FIELD
                              _inputField(
                                controller: controller.passwordController,
                                label: "PASSWORD",
                                hint: "Enter your password",
                                icon: Icons.lock_outline,
                                obscure: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }

                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              // LOGIN BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Obx(
                                      () => OutlinedButton(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : () => _handleLogin(context),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.4,
                                      ),
                                    )
                                        : const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.arrow_forward),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              // CREATE NEW ACCOUNT
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment:
                                  WrapCrossAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => const SignUpPage());
                                      },
                                      child: const Text(
                                        "Create New Account",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                          TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.white60,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            errorStyle: const TextStyle(
              color: Color(0xFFFFD6D6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFFD6D6),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFFD6D6),
                width: 2.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}