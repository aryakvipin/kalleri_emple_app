// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kalleri_emple_app/screen/profile_header.dart';
// import '../Model/usermodel/profilrModels.dart';
//
// import 'Booking card.dart';
// import 'Donation card.dart';
// import 'Tab selector.dart';
//
// /// Combines the three screens shown in the original screenshots:
// /// My Poojas, My Bookings, and Donations — switched via [TabSelector].
// class ProfileActivityPage extends StatefulWidget {
//   final int initialTab;
//
//   const ProfileActivityPage({super.key, this.initialTab = 0});
//
//   @override
//   State<ProfileActivityPage> createState() => _ProfileActivityPageState();
// }
//
// class _ProfileActivityPageState extends State<ProfileActivityPage> {
//   late int _selectedTab = widget.initialTab;
//
//   // ---- Firebase-backed data ----
//   List<BookingItem> _bookings = [];       // TODO: confirm real model name
//   List<DonationItem> _donations = [];
//   bool _loading = true;
//   String? _error;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });
//
//     try {
//       final uid = FirebaseAuth.instance.currentUser?.uid;
//       if (uid == null) {
//         setState(() {
//           _error = 'Please log in to view your activity.';
//           _loading = false;
//         });
//         return;
//       }
//
//       final db = FirebaseFirestore.instance;
//
//       final bookingsSnap = await db
//           .collection('users')
//           .doc(uid)
//           .collection('bookings')
//           .orderBy('createdAt', descending: true)
//           .get();
//
//       final donationsSnap = await db
//           .collection('users')
//           .doc(uid)
//           .collection('donations')
//           .orderBy('createdAt', descending: true)
//           .get();
//
//       setState(() {
//         // _bookings = bookingsSnap.docs
//         //     .map((doc) => BookingItem.fromMap(doc.data())) // TODO: add fromMap
//         //     .toList();
//         // _donations = donationsSnap.docs
//         //     .map((doc) => DonationItem.fromMap(doc.data())) // TODO: add fromMap
//         //     .toList();
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = 'Failed to load data: $e';
//         _loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: false,
//         child: RefreshIndicator(
//           onRefresh: _loadData,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const ProfileHeader(),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
//                   child: TabSelector(
//                     selectedIndex: _selectedTab,
//                     onSelected: (i) => setState(() => _selectedTab = i),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
//                   child: _buildTabContent(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabContent() {
//     if (_loading) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 40),
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     if (_error != null) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 40),
//         child: Center(
//           child: Text(_error!, style: const TextStyle(color: Colors.red)),
//         ),
//       );
//     }
//
//     switch (_selectedTab) {
//       case 0: // My Bookings
//         if (_bookings.isEmpty) {
//           return const Center(child: Text('No bookings yet'));
//         }
//         return Column(
//           children: _bookings
//               .map((item) => BookingCard(item: item, showChevron: true))
//               .toList(),
//         );
//       case 1: // Donations
//         if (_donations.isEmpty) {
//           return const Center(child: Text('No donations yet'));
//         }
//         return Column(
//           children:
//           _donations.map((item) => DonationCard(item: item)).toList(),
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }
// }