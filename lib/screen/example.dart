// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(GetMaterialApp(home: FreelancerHomePage()));
// }
//
// // Dummy controller for demonstration
// class DashboardController extends GetxController {
//  var totalBookings = 10.obs;
//   var earnings = 5000.obs;
//   var rating = 4.5.obs;
// }
//
// class FreelancerHomePage extends StatelessWidget {
//   final DashboardController controller = Get.put(DashboardController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Freelancer Dashboard"),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.account_circle),
//             onPressed: () => Get.to(ProfilePage()), // Navigate to Profile page
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildSummaryCard(
//                   'Bookings',
//                   '${controller.totalBookings.value}',
//                   Icons.calendar_today,
//                   Colors.blue,
//                 ),
//                 _buildSummaryCard(
//                   'Earnings',
//                   '₹${controller.earnings.value}',
//                   Icons.attach_money,
//                   Colors.green,
//                 ),
//                 _buildSummaryCard(
//                   'Reviews',
//                   '${controller.rating.value} ★',
//                   Icons.star,
//                   Colors.orange,
//                 ),
//               ],
//             )),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 _navCard("Active Bookings", Icons.pending, () {
//                   Get.to(ActiveBookingsPage());
//                 }),
//                 _navCard("Completed Bookings", Icons.done, () {
//                   Get.to(CompletedBookingsPage());
//                 }),
//                 _navCard("Notifications", Icons.notifications, () {
//                   Get.to(NotificationsPage());
//                 }),
//                 _navCard("Ratings & Reviews", Icons.star, () {
//                   Get.to(RatingsPage());
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(NewJobPage());
//         },
//         backgroundColor: Colors.deepPurple,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
//     return Expanded(
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Icon(icon, size: 30, color: color),
//               const SizedBox(height: 8),
//               Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               Text(title, style: const TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _navCard(String title, IconData icon, VoidCallback onTap) {
//   return Card(
//     elevation: 5,
//     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//     child: ListTile(
//       leading: Icon(icon, color: Colors.deepPurple),
//       title: Text(title, style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
//       onTap: onTap,
//     ),
//   );
// }
//
// // Dummy Pages Below
//
// class ActiveBookingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Active Bookings")),
//       body: Center(child: Text("Active bookings will appear here.")),
//     );
//   }
// }
//
// class CompletedBookingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Completed Bookings")),
//       body: Center(child: Text("Completed bookings will appear here.")),
//     );
//   }
// }
//
// class NotificationsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Notifications")),
//       body: Center(child: Text("Notifications will appear here.")),
//     );
//   }
// }
//
// class RatingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Ratings & Reviews")),
//       body: Center(child: Text("Ratings and reviews will appear here.")),
//     );
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Center(child: Text("Profile information will appear here.")),
//     );
//   }
// }
//
// class NewJobPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Create New Job")),
//       body: Center(child: Text("Job creation form will appear here.")),
//     );
//   }
// }
