// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../controller/usercontoller/UserNotificationController.dart';
// // import '../controller/usercontoller/user_notification_controller.dart';
//
// // class UserNotificationPage extends StatelessWidget {
// //   final controller = Get.put(UserNotificationController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Notifications"),
// //         backgroundColor: Colors.blueAccent,
// //       ),
// //       body: Obx(() {
// //         if (controller.notifications.isEmpty) {
// //           return const Center(
// //             child: Text("No notifications yet."),
// //           );
// //         }
// //
// //         return ListView.builder(
// //           itemCount: controller.notifications.length,
// //           itemBuilder: (context, index) {
// //             final notification = controller.notifications[index];
// //             return ListTile(
// //               leading: const Icon(Icons.notifications),
// //               title: Text(notification['message'] ?? 'No title'),
// //               subtitle: Text(notification['body'] ?? ''),
// //               trailing: Text(
// //                 notification['timestamp'] != null
// //                     ? DateFormat('dd/MM/yyyy').format((notification['timestamp'] as Timestamp).toDate())
// //                     : '',
// //                 style: const TextStyle(fontSize: 12, color: Colors.grey),
// //               ),
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../utils/GradientBackground.dart';
//
// class UserNotificationPage extends StatelessWidget {
//   final UserNotificationController controller =
//   Get.find<UserNotificationController>();
//
//   @override
//   Widget build(BuildContext context) {
//     controller.markAllAsRead(); // ✅ mark as read on open
//
//     return GradientScaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         backgroundColor: Colors.transparent,
//       ),
//       body: Obx(() {
//         if (controller.notifications.isEmpty) {
//           return const Center(child: Text("No notifications yet."));
//         }
//
//         return ListView.builder(
//           itemCount: controller.notifications.length,
//           itemBuilder: (context, index) {
//             final notification = controller.notifications[index];
//             return ListTile(
//               title: Text(notification['title']),
//               subtitle: Text(notification['body']),
//               trailing: Text(
//                 (notification['timestamp'] as Timestamp?)?.toDate().toString().split(' ')[0] ?? '',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
