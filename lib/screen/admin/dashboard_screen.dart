// // import 'package:flutter/material.dart';
// // import '../../Model/adminmodel/adminmodel.dart';
// // import '../../utils/AppBackground.dart';
// //
// // import 'bookings_screen.dart';
// // import 'booking_detail_screen.dart';
// // import 'notifications_screen.dart';
// //
// // class DashboardScreen extends StatelessWidget {
// //   const DashboardScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final bookings = MockData.bookings;
// //
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [AppColors.maroon, AppColors.maroonDark],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           // Header
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         'Namaskaram, Admin',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.w700,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         'Today, 30 June 2026',
// //                         style: TextStyle(
// //                           color: Colors.white.withOpacity(0.75),
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 _BellButton(onTap: () {
// //                   Navigator.of(context).push(
// //                     MaterialPageRoute(
// //                         builder: (_) => const NotificationsScreen()),
// //                   );
// //                 }),
// //               ],
// //             ),
// //           ),
// //
// //           // Content
// //           Expanded(
// //             child: Container(
// //               width: double.infinity,
// //               decoration: const BoxDecoration(
// //                 color: AppColors.cream,
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// //               ),
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Search bar
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: Container(
// //                             padding:
// //                                 const EdgeInsets.symmetric(horizontal: 16),
// //                             decoration: BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius: BorderRadius.circular(14),
// //                               border: Border.all(color: Colors.grey.shade200),
// //                             ),
// //                             child: Row(
// //                               children: [
// //                                 Icon(Icons.search,
// //                                     color: Colors.grey.shade500, size: 20),
// //                                 const SizedBox(width: 8),
// //                                 Expanded(
// //                                   child: TextField(
// //                                     decoration: InputDecoration(
// //                                       hintText: 'Search anything...',
// //                                       hintStyle: TextStyle(
// //                                           color: Colors.grey.shade400,
// //                                           fontSize: 14),
// //                                       border: InputBorder.none,
// //                                       isCollapsed: true,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 10),
// //                         Container(
// //                           height: 48,
// //                           width: 48,
// //                           decoration: BoxDecoration(
// //                             color: AppColors.maroon,
// //                             borderRadius: BorderRadius.circular(14),
// //                           ),
// //                           child: const Icon(Icons.tune_rounded,
// //                               color: Colors.white, size: 20),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 20),
// //
// //                     // Stat cards grid
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: _StatCard(
// //                             icon: Icons.calendar_today_rounded,
// //                             value: '38',
// //                             label: 'TOTAL\nBOOKINGS',
// //                           ),
// //                         ),
// //                         const SizedBox(width: 14),
// //                         Expanded(
// //                           child: _StatCard(
// //                             icon: Icons.currency_rupee_rounded,
// //                             value: '₹64,250',
// //                             label: 'TOTAL\nDONATIONS',
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 14),
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: _StatCard(
// //                             icon: Icons.groups_rounded,
// //                             value: '312',
// //                             label: 'TOTAL\nDEVOTEES',
// //                           ),
// //                         ),
// //                         const SizedBox(width: 14),
// //                         Expanded(
// //                           child: _StatCard(
// //                             icon: Icons.event_available_rounded,
// //                             value: '8',
// //                             label: 'UPCOMING\nEVENTS',
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //
// //                     const SizedBox(height: 28),
// //
// //                     // Today's bookings header
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         const Text(
// //                           "Today's Bookings",
// //                           style: TextStyle(
// //                             fontSize: 17,
// //                             fontWeight: FontWeight.w700,
// //                             color: AppColors.textDark,
// //                           ),
// //                         ),
// //                         GestureDetector(
// //                           onTap: () {
// //                             Navigator.of(context).push(
// //                               MaterialPageRoute(
// //                                   builder: (_) =>
// //                                       const BookingsScreen(embedded: false)),
// //                             );
// //                           },
// //                           child: const Text(
// //                             'View All',
// //                             style: TextStyle(
// //                               color: AppColors.maroon,
// //                               fontWeight: FontWeight.w600,
// //                               fontSize: 13,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 14),
// //
// //                     ...bookings.map(
// //                       (b) => Padding(
// //                         padding: const EdgeInsets.only(bottom: 12),
// //                         child: _BookingTile(
// //                           booking: b,
// //                           onTap: () {
// //                             Navigator.of(context).push(
// //                               MaterialPageRoute(
// //                                 builder: (_) =>
// //                                     BookingDetailScreen(booking: b),
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class _BellButton extends StatelessWidget {
// //   final VoidCallback onTap;
// //   const _BellButton({required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(10),
// //         decoration: BoxDecoration(
// //           color: Colors.white.withOpacity(0.12),
// //           shape: BoxShape.circle,
// //         ),
// //         child: const Icon(Icons.notifications_none_rounded,
// //             color: Colors.white, size: 22),
// //       ),
// //     );
// //   }
// // }
// //
// // class _StatCard extends StatelessWidget {
// //   final IconData icon;
// //   final String value;
// //   final String label;
// //
// //   const _StatCard({
// //     required this.icon,
// //     required this.value,
// //     required this.label,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: AppColors.creamCard,
// //         borderRadius: BorderRadius.circular(18),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Icon(icon, size: 18, color: AppColors.maroon),
// //           ),
// //           const SizedBox(height: 10),
// //           Text(
// //             value,
// //             style: const TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.w800,
// //               color: AppColors.maroon,
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           Text(
// //             label,
// //             style: TextStyle(
// //               fontSize: 10,
// //               fontWeight: FontWeight.w600,
// //               letterSpacing: 0.3,
// //               color: AppColors.textGrey,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class _BookingTile extends StatelessWidget {
// //   final Booking booking;
// //   final VoidCallback onTap;
// //   const _BookingTile({required this.booking, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final confirmed = booking.status == BookingStatus.confirmed;
// //     final timeStr =
// //         '${booking.dateTime.hour.toString().padLeft(2, '0')}:${booking.dateTime.minute.toString().padLeft(2, '0')} '
// //         '${booking.dateTime.hour >= 12 ? 'PM' : 'AM'}';
// //
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(color: Colors.grey.shade100),
// //         ),
// //         child: Row(
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(12),
// //               child: Container(
// //                 width: 48,
// //                 height: 48,
// //                 color: AppColors.maroon.withOpacity(0.1),
// //                 child: const Icon(Icons.local_fire_department_rounded,
// //                     color: AppColors.maroon),
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     booking.poojaName,
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.w700,
// //                       fontSize: 14,
// //                       color: AppColors.textDark,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 3),
// //                   Text(
// //                     timeStr,
// //                     style:
// //                         TextStyle(fontSize: 12, color: AppColors.textGrey),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //               decoration: BoxDecoration(
// //                 color: confirmed
// //                     ? AppColors.confirmedGreenBg
// //                     : AppColors.pendingOrangeBg,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Text(
// //                 confirmed ? 'Confirmed' : 'Pending',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w700,
// //                   color: confirmed
// //                       ? AppColors.confirmedGreen
// //                       : AppColors.pendingOrange,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:kalleri_emple_app/screen/admin/widgets/bottom_nav.dart';
// import '../../Model/adminmodel/adminmodel.dart';
// import '../../utils/AppBackground.dart';
//
// import 'bookings_screen.dart';
// import 'booking_detail_screen.dart';
// import 'notifications_screen.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedNavIndex = 0;
//
//   void _onNavTap(int index) {
//     if (index == _selectedNavIndex) return;
//
//     // Booking is pushed as its own screen rather than swapped in-place,
//     // so we navigate then reset the nav highlight back to Home on return.
//     if (index == 2) {
//       Navigator.of(context)
//           .push(
//         MaterialPageRoute(
//           builder: (_) => const BookingsScreen(embedded: false),
//         ),
//       )
//           .then((_) => setState(() => _selectedNavIndex = 0));
//       return;
//     }
//
//     setState(() => _selectedNavIndex = index);
//
//     // Adjust these to match your actual named routes / screen widgets.
//     switch (index) {
//       case 0:
//         break; // Already on Home.
//       case 1:
//         Navigator.of(context).pushReplacementNamed('/pooja');
//         break;
//       case 3:
//         Navigator.of(context).pushReplacementNamed('/gallery');
//         break;
//       case 4:
//         Navigator.of(context).pushReplacementNamed('/profile');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bookings = MockData.bookings;
//
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.maroon, AppColors.maroonDark],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Namaskaram, Admin',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Today, 30 June 2026',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.75),
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   _BellButton(onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                           builder: (_) => const NotificationsScreen()),
//                     );
//                   }),
//                 ],
//               ),
//             ),
//
//             // Content
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: AppColors.cream,
//                   borderRadius:
//                   BorderRadius.vertical(top: Radius.circular(28)),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Search bar
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(14),
//                                 border: Border.all(
//                                     color: Colors.grey.shade200),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.search,
//                                       color: Colors.grey.shade500, size: 20),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         hintText: 'Search anything...',
//                                         hintStyle: TextStyle(
//                                             color: Colors.grey.shade400,
//                                             fontSize: 14),
//                                         border: InputBorder.none,
//                                         isCollapsed: true,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             height: 48,
//                             width: 48,
//                             decoration: BoxDecoration(
//                               color: AppColors.maroon,
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             child: const Icon(Icons.tune_rounded,
//                                 color: Colors.white, size: 20),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Stat cards grid
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.calendar_today_rounded,
//                               value: '38',
//                               label: 'TOTAL\nBOOKINGS',
//                             ),
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.currency_rupee_rounded,
//                               value: '₹64,250',
//                               label: 'TOTAL\nDONATIONS',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.groups_rounded,
//                               value: '312',
//                               label: 'TOTAL\nDEVOTEES',
//                             ),
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.event_available_rounded,
//                               value: '8',
//                               label: 'UPCOMING\nEVENTS',
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 28),
//
//                       // Today's bookings header
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Today's Bookings",
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.textDark,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => const BookingsScreen(
//                                         embedded: false)),
//                               );
//                             },
//                             child: const Text(
//                               'View All',
//                               style: TextStyle(
//                                 color: AppColors.maroon,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//
//                       ...bookings.map(
//                             (b) => Padding(
//                           padding: const EdgeInsets.only(bottom: 12),
//                           child: _BookingTile(
//                             booking: b,
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       BookingDetailScreen(booking: b),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: AppBottomNav(
//           currentIndex: _selectedNavIndex,
//           onTap: _onNavTap,
//         ),
//       ),
//     );
//   }
// }
//
// class _BellButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const _BellButton({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.12),
//           shape: BoxShape.circle,
//         ),
//         child: const Icon(Icons.notifications_none_rounded,
//             color: Colors.white, size: 22),
//       ),
//     );
//   }
// }
//
// class _StatCard extends StatelessWidget {
//   final IconData icon;
//   final String value;
//   final String label;
//
//   const _StatCard({
//     required this.icon,
//     required this.value,
//     required this.label,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.creamCard,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, size: 18, color: AppColors.maroon),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//               color: AppColors.maroon,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.3,
//               color: AppColors.textGrey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _BookingTile extends StatelessWidget {
//   final Booking booking;
//   final VoidCallback onTap;
//   const _BookingTile({required this.booking, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final confirmed = booking.status == BookingStatus.confirmed;
//
//     // Fixed: convert 24h -> 12h before formatting, so times no longer
//     // show e.g. "14:30 PM" — now correctly "02:30 PM".
//     final rawHour = booking.dateTime.hour;
//     final hour12 = rawHour % 12 == 0 ? 12 : rawHour % 12;
//     final timeStr =
//         '${hour12.toString().padLeft(2, '0')}:${booking.dateTime.minute.toString().padLeft(2, '0')} '
//         '${rawHour >= 12 ? 'PM' : 'AM'}';
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade100),
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 width: 48,
//                 height: 48,
//                 color: AppColors.maroon.withOpacity(0.1),
//                 child: const Icon(Icons.local_fire_department_rounded,
//                     color: AppColors.maroon),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     booking.poojaName,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     timeStr,
//                     style:
//                     TextStyle(fontSize: 12, color: AppColors.textGrey),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               decoration: BoxDecoration(
//                 color: confirmed
//                     ? AppColors.confirmedGreenBg
//                     : AppColors.pendingOrangeBg,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 confirmed ? 'Confirmed' : 'Pending',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   color: confirmed
//                       ? AppColors.confirmedGreen
//                       : AppColors.pendingOrange,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalleri_emple_app/screen/admin/widgets/bottom_nav.dart';
import '../../Model/adminmodel/adminmodel.dart';
import '../../utils/AppBackground.dart';

import 'add_pooja_screen.dart';
import 'bookings_screen.dart';
import 'booking_detail_screen.dart';
import 'notifications_screen.dart';
import 'gallery_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final Future<String> _adminNameFuture;

  // This page represents index 0 (Home) in the bottom nav.
  static const int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _adminNameFuture = _fetchAdminName();
  }

  Future<String> _fetchAdminName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return "Admin";

    try {
      final doc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();

      final name = doc.data()?['fullName'] as String?;

      if (name != null && name.trim().isNotEmpty) {
        return name.trim();
      }

      return "Admin";
    } catch (e) {
      return "Admin";
    }
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    switch (index) {
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddPoojaScreen(embedded: false)),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const BookingsScreen(embedded: false),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => const AdminGalleryPage(embedded: false)),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => const AdminProfileScreen(embedded: false)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookings = MockData.bookings;

    // Wrapped in Scaffold so descendant Material widgets (TextField, etc.)
    // have the required Material ancestor, and so the bottom nav bar can
    // be attached.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.maroon, AppColors.maroonDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: _adminNameFuture,
                          builder: (context, snapshot) {
                            final name = snapshot.data ?? "Admin";

                            return Text(
                              'Namaskaram, $name',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Today, 30 June 2026',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _BellButton(onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const NotificationsScreen()),
                    );
                  }),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.cream,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border:
                                Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search,
                                      color: Colors.grey.shade500, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search anything...',
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 14),
                                        border: InputBorder.none,
                                        isCollapsed: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.maroon,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.tune_rounded,
                                color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Stat cards grid
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.calendar_today_rounded,
                              value: '38',
                              label: 'TOTAL\nBOOKINGS',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.currency_rupee_rounded,
                              value: '₹64,250',
                              label: 'TOTAL\nDONATIONS',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.groups_rounded,
                              value: '312',
                              label: 'TOTAL\nDEVOTEES',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.event_available_rounded,
                              value: '8',
                              label: 'UPCOMING\nEVENTS',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Today's bookings header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Today's Bookings",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const BookingsScreen(
                                        embedded: false)),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: AppColors.maroon,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      ...bookings.map(
                            (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _BookingTile(
                            booking: b,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingDetailScreen(booking: b),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomNavBar(
        selectedIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BellButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.notifications_none_rounded,
            color: Colors.white, size: 22),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.creamCard,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.maroon),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.maroon,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingTile extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;
  const _BookingTile({required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final confirmed = booking.status == BookingStatus.confirmed;
    final timeStr =
        '${booking.dateTime.hour.toString().padLeft(2, '0')}:${booking.dateTime.minute.toString().padLeft(2, '0')} '
        '${booking.dateTime.hour >= 12 ? 'PM' : 'AM'}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 48,
                height: 48,
                color: AppColors.maroon.withOpacity(0.1),
                child: const Icon(Icons.local_fire_department_rounded,
                    color: AppColors.maroon),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.poojaName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    timeStr,
                    style:
                    TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: confirmed
                    ? AppColors.confirmedGreenBg
                    : AppColors.pendingOrangeBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                confirmed ? 'Confirmed' : 'Pending',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: confirmed
                      ? AppColors.confirmedGreen
                      : AppColors.pendingOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}