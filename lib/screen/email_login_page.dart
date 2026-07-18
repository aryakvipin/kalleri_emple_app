// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/usercontoller/email_login_controller.dart';
//
// class EmailLoginPage extends StatelessWidget {
//   final EmailLoginController controller = Get.put(EmailLoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text("Login with Gmail OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller.emailController,
//               decoration: InputDecoration(
//                 labelText: "Enter your Gmail",
//                 prefixIcon: Icon(Icons.email),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: controller.sendSignInLink,
//               child: const Text("Send Login Link"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
